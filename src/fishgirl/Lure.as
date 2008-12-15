package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Lure extends Actor
	{
		/**
		 * Size of the lure. Use the Fish.SMALL - Fish.LARGE variables.
		 */
		public var size:uint;
		
		public var oceanX:Number, oceanY:Number;
		
		private static var gfx:Array = [ DancGraphics.lureSmall, DancGraphics.lureMedium, DancGraphics.lureLarge, DancGraphics.lureBomb ];
		
		public function Lure(size:uint) 
		{
			this.size = size;
			var spr:Sprite = new (gfx[size] as Class)();
			if (size == Fish.SMALL) {
				spr.x -= spr.width / 2;
				spr.y -= spr.height / 2;
			}
			addChild(spr);
		}
		
		public override function update():void {
			super.update();
			
			
		}
	}
	
}