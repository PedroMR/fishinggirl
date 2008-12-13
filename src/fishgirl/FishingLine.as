package fishgirl 
{
	import fishgirl.physics.Particle;
	import fishgirl.physics.Point2D;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class FishingLine extends Actor
	{
		public var lureX:Number, lureY:Number, length:Number;
		public var anchor:Point2D;
				
		internal var lure:Particle, lineJoints:Array;
		
		public function FishingLine(x:Number, y:Number) 
		{			
			var panchor:Particle = new Particle(new Point2D(x, y));
			anchor = panchor.state.pos;
			var l:Number = 8;
			lineJoints = [];			
			lineJoints[0] = new Particle(new Point2D(x, y), panchor, l, 10);			
			for (var i:uint = 1; i < 5; ++i) {
				lineJoints[i] = new Particle(new Point2D(x, y), lineJoints[i-1], l, 1);
			}
			lure = lineJoints[lineJoints.length - 1];
			length = 10;
		}
		
		public function setAnchor(x:Number, y:Number) : void {
			anchor.x = x; anchor.y = y;
		}
		
		public function setLength(length:Number) : void {
			this.length = length;
		}
		
		public override function update() : void {
			for each(var p:Particle in lineJoints)
				p.update();
			lureX = anchor.x;
			lureY = anchor.y+length;
			
			graphics.clear();
			graphics.lineStyle(0, 0);
			graphics.moveTo(anchor.x, anchor.y);
			graphics.lineTo(lureX, lureY);			
			
			graphics.lineStyle(0, 0xFF00FF);
			graphics.moveTo(anchor.x, anchor.y);
			for each(p in lineJoints)
				graphics.lineTo(p.state.pos.x, p.state.pos.y);
			//graphics.lineTo(lure.state.pos.x, lure.state.pos.y);			
		}		
	}
	
}