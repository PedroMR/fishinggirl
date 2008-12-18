package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Lure extends Actor
	{
		public static const NONE:uint = 255;
		/**
		 * Size of the lure. Use the Fish.SMALL - Fish.LARGE variables.
		 */
		public var size:uint;
		public var fish:Fish;
		
		public var oceanX:Number, oceanY:Number;
		private var spr:Sprite;
		public var thrown:Boolean;
		
		private static var gfx:Array = [ DancGraphics.lureSmall, DancGraphics.lureMedium, DancGraphics.lureLarge, DancGraphics.lureBomb ];
		
		public function Lure(size:uint) 
		{
			setSize(size);
		}
		
		public function setSize(size:uint):void {
			if (spr != null) {
				removeChild(spr);
				spr = null;
			}
			this.size = size;
			if (size != NONE) {
				thrown = false;
				fish = null;
				spr = new (gfx[size] as Class)();
				if (size == Fish.SMALL) {
					spr.x -= spr.width / 2;
					spr.y -= spr.height / 2;
				}
				addChild(spr);
			}
		}
		
		public override function update():void {
			super.update();
			if (oceanY > 0) thrown = true;
		}
		
		public function caught(fish:Fish) : void {
			setSize(NONE);
			this.fish = fish;
		}
		
		public function eaten() : void {
			setSize(NONE);
		}
		
		public function isOutOfTheWater() : Boolean {
			return thrown && oceanY < 10;
		}
	}
	
}
