package fishgirl
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
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
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			trace("init");
			
			actors = [];
			
			backdrop = new Backdrop();
			addChild(backdrop);
			
			ocean = new Ocean;
			addChild(ocean);
			
			addEventListener(Event.ENTER_FRAME, updateFrame);
		}
		
		public function addActor(a:Actor) : void {
			//actors.push(a);
			addChild(a);
		}
		
		private function updateFrame(e:Event = null):void
		{
			backdrop.update();
			ocean.update();
			
			for each (var a:Actor in actors) {
				trace(a);
				a.update();
			}
		}
		
	}
	
}