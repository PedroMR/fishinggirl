package fishgirl 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Fish extends Actor
	{
		internal var sprite:Sprite;
		
		internal var target:Point;
		
		internal static const VEL_FLIP_CHANGE:Number = 0.1;
		internal static const VELOCITY_INCREASE:Number = 0.1;
		internal static const VELOCITY_MAX:Number = 5;
		
		public function Fish() 
		{
			sprite = new DancGraphics.fishLarge1();
			addChild(sprite);
			
			setVelocity(0, 0);
			target = new Point(x + 150, y);
		}
		
		public override function update() : void 
		{
			super.update();
			
			var dx:Number = Math.abs(target.x - x);
			var dy:Number = Math.abs(target.y - y);
			
			var k:Number = 30;
			if (dx < Math.abs(vx * k)) vx -= 3*vx / k;
			else {
				vx += (vx > 0) ? VELOCITY_INCREASE : -VELOCITY_INCREASE;
				if ( Math.abs(vx) > VELOCITY_MAX ) {
					vx = (vx > 0) ? VELOCITY_MAX : -VELOCITY_MAX;
				}
			}
			
			
			if (dx < 20) target = new Point( Math.random() * 600, y );
			setVelocity((target.x > x) ? 5 : -5, 0);
			
			if ((vx > VEL_FLIP_CHANGE && scaleX > 0) || (vx < -VEL_FLIP_CHANGE && scaleX < 0)) scaleX = -scaleX;
		}
		
	}
	
}