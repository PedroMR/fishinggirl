package fishgirl.physics 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Point2D 
	{		
		public var x:Number, y:Number;
		
		public function Point2D(x:Number=0, y:Number=0) 
		{
			this.x = x;
			this.y = y;
		}
		
		public function zero() : Point2D {
			x = 0; y = 0;
			return this;
		}
		
		/**
		 * Multiply each component by a scalar.
		 * @param	k
		 * @param dst Destination point (or null to create a new one)
		 */
		public function scaleInto(k:Number, dst:Point2D=null) : Point2D {
			if (dst == null) dst = new Point2D();
			dst.x = x * k; dst.y = y * k;
			return dst;
		}
		
		public function distance(p2:Point2D) : Number {
			var dx:Number = p2.x - this.x;
			var dy:Number = p2.y - this.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public function scale(k:Number) : Point2D {
			x *= k; y *= k;
			return this;
		}
		
		public function clone() : Point2D {
			return new Point2D(x, y);
		}
		
		public function copyFrom(p2:Point2D) : Point2D {
			this.x = p2.x;
			this.y = p2.y;
			return this;
		}
		
		public function add(p2:Point2D) : Point2D {
			x += p2.x;
			y += p2.y;
			return this;			
		}
		
		public function sub(p2:Point2D) : Point2D {
			x -= p2.x;
			y -= p2.y;
			return this;			
		}
		
		public function addInto(p2:Point2D, dst:Point2D) : Point2D {
			dst.x = x + p2.x;
			dst.y = y + p2.y;
			return dst;
		}
	}
	
}