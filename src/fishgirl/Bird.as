package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Bird extends Actor
	{
		public function Bird() 
		{
			addChild(new DancGraphics.bird());
			vx = 10;
		}
		
		override public function update() : void
		{
			super.update();
			
			if (x > stage.stageWidth) x = -100;
		}
	}
	
}