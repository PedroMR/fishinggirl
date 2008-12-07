package fishgirl 
{
	
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
	}
	
}