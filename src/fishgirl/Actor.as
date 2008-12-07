package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Actor extends Sprite
	{		
		protected var tick:uint;
		protected var vx:Number, vy:Number;
		
		public function Actor() 
		{
			tick = 0;
		}
		
		public function setVelocity( vx:Number, vy:Number ) : void {
			this.vx = vx;
			this.vy = vy;
		}
		
		public function update() : void 
		{
			tick++;
			
			x += vx;
			y += vy;
		}
	}
	
}