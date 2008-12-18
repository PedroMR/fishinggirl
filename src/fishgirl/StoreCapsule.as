package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class StoreCapsule extends Actor
	{
		public var type:uint;
		private var sprite:Sprite;
		
		public static const SMALL_LURE:uint = 0,
			MEDIUM_LURE:uint = 1,
			SILVER_ROD:uint = 2,
			LARGE_LURE:uint = 3,
			GOLDEN_ROD:uint = 4,
			BOMB_LURE:uint = 5,
			LEGENDARY_ROD:uint = 6,
			NUM_TYPES:uint = 7;
			
		
		public function StoreCapsule(index:uint) 
		{
			type = index;
			sprite = new DancGraphics.storeCapsule();
			sprite.x = -sprite.width / 2;
			sprite.y = -sprite.height / 2;
			addChild(sprite);
			
			graphics.lineStyle(0, 0xFF0000);
			graphics.drawCircle(0, 0, 3);
			
			x = 200 * (index);
			y = 0;
		}
		
	}
	
}