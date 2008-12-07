package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Mountain extends Actor
	{
		public static const FAR:uint = 0;
		public static const MIDDLE:uint = 1;
		
		internal var spr:Array = [
			[ new DancGraphics.FarGround1(), new DancGraphics.FarGround2(), new DancGraphics.FarGround3() ],
			[ new DancGraphics.MidGround1(), new DancGraphics.MidGround2(), new DancGraphics.MidGround3() ],
		];
		
		internal var yoff:Array = [
			[56, 0, 120],
			[-8, 0, 29],
		];
		
		public function Mountain(type:uint, id:uint, x:Number, y:Number) 
		{
			var s:Sprite = spr[type][id];
			s.x = x;
			s.y = y + yoff[type][id];
			addChild(s);
		}	
	}
	
}