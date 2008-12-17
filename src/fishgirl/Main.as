package fishgirl
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.setInterval;
	import flash.utils.Timer;
	import mx.core.SpriteAsset;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Main extends Sprite 
	{
		
		internal var actors:Array;
		
		public var world:World;
		public var score:ScoreDisplay;
		
		public static var game:GameState;
		
		public static var keysheld:Array = [];
		public static var buttonIsDown:Boolean = false;
		
		internal var fps:TextField, nframes:uint=0;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);						
		}
		
		public function handleMouseDown(e:MouseEvent = null) :void {
			buttonPressed();
		}
		
		public function handleMouseUp(e:MouseEvent = null) :void {
			buttonReleased();
		}
		
		public function handleKeyDown(e:KeyboardEvent = null) :void {
			if (keysheld[Keyboard.F12]) trace("down " + e.keyCode);
			
			if (!keysheld[e.keyCode]) {
				if (e.keyCode == Keyboard.SPACE) buttonPressed();
			}
			
			keysheld[e.keyCode] = true;
			keysheld[e.charCode] = true;
			
		}
		
		public function handleKeyUp(e:KeyboardEvent=null) :void {
			if (keysheld[e.keyCode]) {
				if (e.keyCode == Keyboard.SPACE) buttonReleased();
			}
			
			keysheld[e.keyCode] = false;
			keysheld[e.charCode] = false;
		}
		
		public function buttonPressed() : void {
			//trace("bp " + state.state);
			buttonIsDown = true;
			
			switch (game.state) {
				case GameState.READY_TO_CAST:
					if (world.player.state == Bear.IDLE) {
						world.player.setState(Bear.PREPARING_CAST);
						setState(GameState.CASTING);
					}
					break;
			}
		}
		
		public function buttonReleased() : void {
			buttonIsDown = false;
			
			switch (game.state) {
				case GameState.CASTING:
					world.player.setState(Bear.CASTING);
					setState(GameState.FISHING);
					break;				
			}
		}
		
		public function setState(state:uint) : void {
			trace("gamestate: " + state);
			game.ticksInState = 0;
			game.state = state;
				
			switch (game.state) {
				case GameState.READY_TO_CAST:
					world.player.rod.lure.setSize(Fish.SMALL);
					world.camera.setTargetCentreOn(world.town, 0, 0);
					break;
				case GameState.CASTING:
					world.camera.setTargetCentre(world.groupie.x, world.town.y);
					break;
				case GameState.FISHING:
					world.camera.followTarget(world.player.rod.lure);
					break;
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			fps = new TextField();
			fps.x = 10; fps.y = stage.stageHeight - 20;
			fps.textColor = 0xFFFFFF;
			fps.text = "00";
			setInterval(updateFPS, 1000);
			
			game = new GameState();
			
			world = new World();
			addChild(world);
			
			score = new ScoreDisplay();
			addChild(score);
			score.x = stage.stageWidth;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);

			actors = [];

			addChild(fps);

			addEventListener(Event.ENTER_FRAME, updateFrame);
			
			setState(GameState.READY_TO_CAST);
		}
		
		public function addActor(a:Actor) : void {
			//actors.push(a);
			addChild(a);
		}
		
		private function updateFPS(e:TimerEvent = null):void {
			fps.text = nframes+"fps";
			nframes = 0;
		}
		
		private function updateFrame(e:Event = null):void
		{
			Actor.nActors = 0;
			nframes++;
			game.ticksInState++;
			world.update();
			score.update();
			
			for each (var a:Actor in actors) {
				a.update();
			}
			
			//world.camera.dbg.text = Actor.nActors + " actors updated"; Actor.nActors = 0;
			
			switch(game.state) {
				case GameState.CASTING:
					if (world.player.state == Bear.MISCAST)
						setState(GameState.MISCAST);
					break;
				case GameState.MISCAST:
					if (world.player.state == Bear.IDLE)
						setState(GameState.READY_TO_CAST);
					break;
				case GameState.FISHING:
					if(buttonIsDown && (game.ticksInState%2==0))
						world.player.rod.line.pullLine();
					var lure:Lure = world.player.rod.lure;
					if (world.player.rod.isReeledIn()) {
						world.camera.stopFollowing();
						var fish:Fish = lure.fish;
						if (fish) {
							game.points += fish.score;
							fish.disappear();
						}
						setState(GameState.READY_TO_CAST);
					}
					break;
			}
		}
		
	}
	
}