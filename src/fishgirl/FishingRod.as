package fishgirl 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class FishingRod extends Actor
	{
		internal var sprite:Sprite, point:Sprite;
		internal var line:FishingLineVerlet;
		protected var ocean:Ocean;
		public var lure:Lure;
		
		public function FishingRod(ocean:Ocean) 
		{
			this.ocean = ocean;
			
			sprite = new DancGraphics.fishingRod();
			graphics.beginFill(0xFF0000);
			graphics.drawCircle(0, 0, 3);
			graphics.endFill();
			sprite.x -= 15;
			sprite.y -= sprite.height / 2;
			
			point = new Sprite();
			point.x = sprite.width - 3;
			point.y = sprite.height / 2 + 3;
			sprite.addChild(point);
			
			line = new FishingLineVerlet(point.x, point.y);
			addChild(line);
			
			point.graphics.beginFill(0xFF0000, 0.5);
			point.graphics.drawCircle(0, 0, 3);
			point.graphics.endFill();
			
			line.setLength(50);
			addChild(sprite);
			
			lure = new Lure(Fish.SMALL);
			addChild(lure);
		}
		
		public override function set rotation(val:Number) : void {
			sprite.rotation = val;
		}
		
		public override function get rotation():Number {
			return sprite.rotation;
		}
		
		public override function update():void {
			//line.setAnchor(sprite.x + sprite.width, sprite.y - sprite.height);			
			var p:Point = new Point(point.x, point.y);
			p = this.globalToLocal(sprite.localToGlobal(p));
			line.setAnchor(p.x, p.y);
			line.update();
			lure.x = line.lureX; lure.y = line.lureY;
			var pt:Point = ocean.globalToLocal(localToGlobal(new Point(lure.x, lure.y)));
			lure.oceanX = pt.x; lure.oceanY = pt.y;
			if (lure.oceanY > 10) lure.thrown = true;
		}
		
		public function release():void {
			line.releaseSegment();
		}
		
		public function isReeledIn():Boolean {
			return line.freed == 1;
		}
	}
	
}