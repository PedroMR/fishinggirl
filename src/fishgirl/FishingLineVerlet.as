package fishgirl 
{
	import fishgirl.physics.Point2D;
	import fishgirl.physics.Rope;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class FishingLineVerlet extends FishingLine
	{
		protected var rope:Rope;
		protected var segments:uint = 30, freed:uint = 1;	
		
		public function FishingLineVerlet(x:Number, y:Number) 
		{
			super(x, y);
			anchor = new Point2D(x, y);
			rope = new Rope(segments, 20, x, y);
			releaseSegments(3);
			rope.setMass(0, Rope.MASS_FIXED);
			rope.setMass(segments-1, 50);
		}
		
		public function releaseSegment() : void {
			releaseSegments(freed + 1);
		}
		
		public function releaseSegments(n:int = -1) : void {
			if (n == -1) n = segments - 1;
			if (n > segments - 1 || n <= 0) return;
			freed = n;
			for (var i:uint = segments-2; i > 0; i--) {
				if (i > segments-1-n) 
					rope.setMass(i, 1);
				else {
					rope.setMass(i, Rope.MASS_FIXED);
					rope.setPosition(i, anchor.x, anchor.y);
				}
			}
		}

		public override function update() : void {
			if (Main.keysheld[81]) releaseSegments(freed + 1);
			if (Main.keysheld[65]) releaseSegments(freed - 1);
			
			rope.setPosition(segments-freed-1, anchor.x, anchor.y);
			rope.update();
			graphics.clear();
			graphics.lineStyle(0, 0);
			graphics.moveTo(anchor.x, anchor.y);
			for (var i:uint = segments-freed; i < segments; i++ ) {
				graphics.lineTo(rope.pos[i].x, rope.pos[i].y);
			}
		}
	}
	
}