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
		
		public var world:World;
		
		public static var keysheld:Array = [];
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);						
		}
		
		public function handleKeyDown(e:KeyboardEvent = null) :void {
			trace("down " + e.keyCode);
			keysheld[e.keyCode] = true;
			keysheld[e.charCode] = true;
		}
		
		public function handleKeyUp(e:KeyboardEvent=null) :void {
			keysheld[e.keyCode] = false;
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			trace("init");
			
			world = new World();
			addChild(world);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);

			actors = [];
			
			addEventListener(Event.ENTER_FRAME, updateFrame);
		}
		
		public function addActor(a:Actor) : void {
			//actors.push(a);
			addChild(a);
		}
		
		private function updateFrame(e:Event = null):void
		{
			world.update();
			
			for each (var a:Actor in actors) {
				trace(a);
				a.update();
			}
		}
		
	}
	
}