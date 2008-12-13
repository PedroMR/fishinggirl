package fishgirl.physics 
{
	import flash.display.Graphics;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Rope 
	{
		protected var segmentLength:Number, segmentLengthSq:Number;
		protected var segments:uint;
		protected var masses:Array, invmass:Array, lastPos:Array;
		public var pos:Array;
		protected var forceA:Array;
		protected var gravity:Point2D = new Point2D(0, 9.8);
		
		private static var p1:Point2D = new Point2D(), p2:Point2D = new Point2D();

		public var dt:Number = 0.4, dt2:Number = dt * dt;
		
		private var NUM_ITER:uint = 20;
		
		public static const MASS_FIXED:Number = Number.MAX_VALUE;
		
		public function Rope(segs:uint, segLen:Number, x0:Number, y0:Number) 
		{
			masses = new Array(segs);
			invmass = new Array(segs);
			forceA = new Array(segs);
			pos = new Array(segs);
			lastPos = new Array(segs);
			segments = segs;			
			segmentLength = segLen;
			segmentLengthSq = segmentLength * segmentLength;
			
			for (var i:uint = 0; i < segs; ++i) {
				pos[i] = new Point2D(x0,y0+i*segmentLength);
				lastPos[i] = new Point2D(x0, y0+i*segmentLength);
				forceA[i] = new Point2D();
				masses[i] = MASS_FIXED;
				invmass[i] = 0;
			}
		}
		
		public function setMass(idx:uint, mass:Number) : void {
			masses[idx] = mass;
			invmass[idx] = mass==MASS_FIXED? 0 : 1/mass;
		}
		
		public function setPosition(idx:uint, x:Number, y:Number) : void {
			pos[idx].x = x;
			pos[idx].y = y;
		}
		
		public function renderDebug(g:Graphics) : void {			
			g.lineStyle(0, 0x000000);
			g.drawCircle(pos[0].x, pos[0].y, 5);
			g.moveTo(pos[0].x, pos[0].y);
			for (var i:uint = 1; i < segments; ++i) {
				g.lineTo(pos[i].x, pos[i].y);
				g.drawCircle(pos[i].x, pos[i].y, 2);
			}
		}
		
		public function render(g:Graphics) : void {			
			g.lineStyle(0, 0x000000);
			g.moveTo(pos[0].x, pos[0].y);
			for (var i:uint = 1; i < segments; ++i) {
				g.lineTo(pos[i].x, pos[i].y);
			}
		}
		
		private function verlet():void {
			for (var i:uint = 0; i < segments; ++i) {
//				trace(forceA[i], pos[i]);
				if (masses[i] == MASS_FIXED) continue;
				p1.copyFrom(forceA[i]).scale(dt2).add(pos[i]).sub(lastPos[i]).add(pos[i]);
				lastPos[i].copyFrom(pos[i]); // todo just exchange the arrays?
				pos[i].copyFrom(p1);
			}
		}
		
		private function forces():void {
			for (var i:uint = 0; i < segments; ++i) {
				if (masses[i] != MASS_FIXED) {
					forceA[i].copyFrom(gravity);
					if (pos[i].y > 0 && pos[i].x > 0) {
						// in water
						p1.copyFrom(lastPos[i]).sub(pos[i]).scale(3);
						forceA[i].add(p1);
						//forceA[i].scale(0.2);
					}
				} else {
					forceA[i].zero();
				}
			}
		}
		
		private function satisfyConstraints():void {
			for (var j:uint = 0; j < NUM_ITER; ++j) {
				for (var i:uint = segments - 1; i > 0; --i) {
					//trace("pos " + [i, pos[i]]);
					if (masses[i] == masses[i-1]) {
						// no masses					
						p1.copyFrom(pos[i - 1]).sub(pos[i]);
						p1.scale(segmentLengthSq / (p1.dot(p1) + segmentLengthSq) - 0.5);
						if(masses[i]!=MASS_FIXED) 
							pos[i].sub(p1);
						if(masses[i-1]!=MASS_FIXED) 
							pos[i - 1].add(p1);
					} else {
						p1.copyFrom(pos[i - 1]).sub(pos[i]);
						var dl:Number = Math.sqrt(p1.dot(p1));
						var diff:Number = (dl - segmentLength) / (dl * (invmass[i - 1] + invmass[i]));
						p1.scale(diff);
						p2.copyFrom(p1);
						p1.scale(invmass[i]);
						p2.scale(invmass[i - 1]);
						//trace("p1, mass, dl, diff " + [p1, invmass[i], dl, diff]);
						if(masses[i]!=MASS_FIXED) 
							pos[i].add(p1);
						if(masses[i-1]!=MASS_FIXED) 
							pos[i - 1].sub(p2);
 //
// Pseudo-code to satisfy (C2)
//delta = x2-x1;
//deltalength = sqrt(delta*delta);
//diff = (deltalength-restlength)
///(deltalength*(invmass1+invmass2));
//x1 += invmass1*delta*diff;
//x2 -= invmass2*delta*diff;
 						
					}					
				}
			}
		}
		
		public function update() : void {
			forces();
			verlet();
			satisfyConstraints();
		}
	}
	
}