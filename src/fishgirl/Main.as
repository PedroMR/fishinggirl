﻿package fishgirl
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
		
		public var game:GameState;
		
		public static var keysheld:Array = [];
		
		internal var fps:TextField, nframes:uint=0;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);						
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
			switch (game.state) {
				case GameState.CASTING:
					world.player.setState(Bear.CASTING);
					setState(GameState.READY_TO_CAST);
					break;				
			}
		}
		
		public function setState(state:uint) : void {
			trace("gamestate: " + state);
			this.game.state = state;
			
			switch (game.state) {
				case GameState.READY_TO_CAST:
					world.camera.setTargetCentreOn(world.town, 0, 0);
					break;
				case GameState.CASTING:
					world.camera.setTargetCentre(world.groupie.x, world.town.y);
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
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);

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
			nframes++;
			world.update();
			
			
			for each (var a:Actor in actors) {
				a.update();
			}
		}
		
	}
	
}