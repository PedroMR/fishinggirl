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
			vx = 8;
			randomizePosition();
			x += tick * vx;
		}
		
		public function randomizePosition() : void {
			if (Math.random() >= 0.5) {
				x = 1200 + Math.random()*400;
				vx = -Math.abs(vx);
				scaleX = -Math.abs(scaleX);
			} else {
				x = -100 - Math.random()*400;
				vx = Math.abs(vx);
				scaleX = Math.abs(scaleX);
			}
			y = Math.random() * 200 + 50;
			tick = Math.random() * 2000;
		}
		
		override public function update() : void
		{
			super.update();
			
			vy = Math.sin(tick / 15);
			var amp:Number = 0.06;
			scaleY = Math.sin(tick / 5)*amp+1-amp/2;
			if (vx > 0 && x > 1000) randomizePosition();
			else if (vx < 0 && x < -100) randomizePosition();
		}
	}
	
}