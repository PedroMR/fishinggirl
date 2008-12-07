﻿package fishgirl 
{
	import flash.display.Graphics;
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
		
		internal static const VEL_FLIP_CHANGE:Number = -0.15;
		internal static const DSCALE_FLIP_CHANGE:Number = 0.09;
		internal static const VELOCITY_INCREASE:Number = 0.1;
		internal static const VELOCITY_MAX:Number = 5;
		
		public function Fish() 
		{
			sprite = new DancGraphics.fishLarge1();
			sprite.x = -sprite.width / 2;
			sprite.y = -sprite.height / 2;
			addChild(sprite);
			
			setVelocity(0, 0);
			target = new Point(x + 150, y);
		}
		
		public override function update() : void 
		{
			
			var dx:Number = target.x - x;
			var dy:Number = target.y - y;
			
			vy = Math.sin(tick/5)*0.5;
			
			if (dx > 0) {				
				if (vx < VELOCITY_MAX) {
					vx += VELOCITY_INCREASE;
					if (vx > VELOCITY_MAX)
						vx = VELOCITY_MAX;
				}
				
				super.update();
				
				if (target.x <= x) {
					chooseTarget();
				}
			} else {
				if (vx > -VELOCITY_MAX) {
					vx -= VELOCITY_INCREASE;
					if (vx < -VELOCITY_MAX)
						vx = -VELOCITY_MAX;
				}
				
				super.update();
				
				if (target.x >= x) {
					chooseTarget();
				}
			}
			if ((vx > VEL_FLIP_CHANGE && scaleX > -1)) {
				scaleX -= DSCALE_FLIP_CHANGE;
			} else if ((vx < VEL_FLIP_CHANGE && scaleX < 1)) {
				scaleX += DSCALE_FLIP_CHANGE;
			}
			
			/*
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(3, 0xFF00FF);
			g.moveTo(0, 0);
			g.lineTo((scaleX/Math.abs(scaleX))*dx, dy);
			*/
		}
		
		public function chooseTarget() : void {
			target = new Point( Math.random() * 600, y );
		}
		
	}
	
}