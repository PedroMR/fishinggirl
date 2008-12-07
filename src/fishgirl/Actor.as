package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Actor extends Sprite
	{		
		public var container:ActorContainer;
		protected var tick:uint;
		protected var vx:Number, vy:Number;
		
		/**
		 * z=1 means the object is in the fore plane, i.e., camera movement is 1:1.
		 * Larger zs divide camera movement proportionally.
		 */
		public var z:Number;
		
		public function Actor() 
		{
			tick = 0;
			z = 1;
		}
		
		public function setVelocity( vx:Number, vy:Number ) : void {
			this.vx = vx;
			this.vy = vy;
		}
		
		public function moveCamera( dx:Number, dy:Number ) : void {
			this.x -= dx / z;
			this.y -= dy / z;
		}
		
		public function update() : void 
		{
			tick++;
			
			x += vx;
			y += vy;
		}
	}
	
}