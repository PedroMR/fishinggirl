package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class FishingRod extends Actor
	{
		internal var sprite:Sprite;
		
		public function FishingRod() 
		{
			sprite = new DancGraphics.fishingRod();
			addChild(sprite);
			graphics.beginFill(0xFF0000);
			graphics.drawCircle(0, 0, 3);
			graphics.endFill();
			sprite.x -= 15;
			sprite.y -= sprite.height / 2;
		}
		
	}
	
}