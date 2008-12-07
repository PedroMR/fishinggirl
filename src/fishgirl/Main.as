package fishgirl
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import mx.core.SpriteAsset;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Main extends Sprite 
	{
		
		internal var actors:Array;
		
		internal var backdrop:Backdrop;
		internal var ocean:Ocean;
		
		internal var keysheld:Array = [];
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);						
		}
		
		public function handleKeyDown(e:KeyboardEvent = null) :void {
			keysheld[e.keyCode] = true;
		}
		
		public function handleKeyUp(e:KeyboardEvent=null) :void {
			keysheld[e.keyCode] = false;
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			trace("init");
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);

			actors = [];
			
			backdrop = new Backdrop();
			addChild(backdrop);
			
			ocean = new Ocean;
			ocean.y = 300;
			ocean.x = 100;
			ocean.scaleX = ocean.scaleY = 1;
			addChild(ocean);
			
			addEventListener(Event.ENTER_FRAME, updateFrame);
		}
		
		public function addActor(a:Actor) : void {
			//actors.push(a);
			addChild(a);
		}
		
		private function updateFrame(e:Event = null):void
		{
			var vel_cam:Number = 10;
			if (keysheld[Keyboard.LEFT]) x += vel_cam;
			if (keysheld[Keyboard.RIGHT]) x -= vel_cam;
			if (keysheld[Keyboard.UP]) y += vel_cam;
			if (keysheld[Keyboard.DOWN]) y -= vel_cam;
			
			backdrop.update();
			ocean.update();
			
			for each (var a:Actor in actors) {
				trace(a);
				a.update();
			}
		}
		
	}
	
}