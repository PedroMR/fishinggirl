package fishgirl 
{
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Util 
	{
		public static function randomElement( a:Array ) : Object {
			var r:Number = Math.random() * a.length;
			return a[Math.floor(r)];
		}
		
		public static function newRotate( radians:Number) : Matrix {
			var mat:Matrix = new Matrix();
			mat.rotate(radians);
			return mat;
		}
	}
	
}