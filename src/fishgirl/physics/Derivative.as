package fishgirl.physics 
{
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Derivative 
	{
		public var dpos:Point2D;
		public var dvel:Point2D;
		
		public function Derivative(dpos:Point2D=null, dvel:Point2D=null) 
		{
			this.dpos = dpos==null ? new Point2D() : dpos.clone();
			this.dvel = dvel==null ? new Point2D() : dvel.clone();
		}		
		
		public function zero() : Derivative {
			dpos.zero(); dvel.zero();
			return this;
		}
	}
	
}