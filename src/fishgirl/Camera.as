package fishgirl 
{
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Camera 
	{		
		internal var world:World;
		internal var vx:Number, vy:Number;
		
		public function Camera(world:World) 
		{
			vx = vy = 0;
			this.world = world;
		}
	
		public function update(left:Boolean, up:Boolean, right:Boolean, down:Boolean, turbo:Number) : void {
			var inc:Number = 1*turbo;
			var max:Number = 10*turbo;
			
			if (left) vx -= inc; 
			else if (right) vx += inc;
			else if (vx < 0) vx += inc;
			else if (vx > 0) vx -= inc;
			
			if (up) vy -= inc; 
			else if (down) vy += inc;
			else if (vy < 0) vy += inc;
			else if (vy > 0) vy -= inc;
			
			if (vx < -max) vx = -max;
			else if (vx > max) vx = max;
			if (vy < -max) vy = -max;
			else if (vy > max) vy = max;
			
			world.moveCamera(vx, vy);
		}
	}
	
}