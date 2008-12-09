package fishgirl 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Mountain extends Actor
	{
		public static const FAR:uint = 0;
		public static const MIDDLE:uint = 1;
		
		internal var spr:Array = [
			[ DancGraphics.FarGround1, DancGraphics.FarGround2, DancGraphics.FarGround3 ],
			[ DancGraphics.MidGround1, DancGraphics.MidGround2, DancGraphics.MidGround3 ],
		];
		
		internal var trees:Array = [
			[ DancGraphics.FarTree, DancGraphics.FarTree2 ],
			[ DancGraphics.MidTree, DancGraphics.MidTree2 ],
		];
		
		internal var yoff:Array = [
			[56, 0, 120],
			[-8, 0, 29],
		];
		
		internal var type:uint;
		internal var sprite:Sprite;
		
		public function Mountain(type:uint, id:uint, x:Number, y:Number) 
		{
			this.type = type;
			sprite = new (spr[type][id])();
			sprite.x = x;
			sprite.y = y + yoff[type][id];
			
			addChild(sprite);
		}	
		
		public function addTree() : void 
		{
			var p:Point = new Point();
			var t:Sprite = new (Util.randomElement(trees[(type+1)%2]))();
			t.x = Math.floor(Math.random()*sprite.width);
			p.x = t.x;
			var p2:Point = sprite.localToGlobal(p);
			for (var ty:uint = 0; ty < sprite.height; ty+=10) {
				p.y = ty;
				t.y = ty;
				p2 = sprite.localToGlobal(p);
				if (sprite.hitTestPoint(p2.x, p2.y, true)) {
					trace( "hit " + p2+" against "+[sprite.x,sprite.y]);
					addChild(t);
					t.y = p.y;
					break;
				}
			}
			p.y = sprite.height / 2;
			p2 = sprite.localToGlobal(p);
			trace( "never hit " + p+" (p2 "+p2+") against "+[sprite.x,sprite.y]);
		}
	}
	
}