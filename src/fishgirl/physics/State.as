package fishgirl.physics 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class State 
	{
		public var pos:Point2D;
		public var vel:Point2D;
		
		public function State(pos:Point2D=null, vel:Point2D=null) 
		{
			if (pos == null) 
				this.pos = new Point2D();
			else 
				this.pos = pos.clone();
			if (vel == null)
				this.vel = new Point2D();
			else
				this.vel = vel.clone();
		}
		
	}
	
}