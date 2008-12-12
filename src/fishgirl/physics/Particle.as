package fishgirl.physics 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Particle 
	{
		public var state:State;
		
		public static var tempState:State = new State(); // for evaluate()
		public static var tempPoint:Point2D = new Point2D(); // for evaluate()
		public static var tempPoint2:Point2D = new Point2D(); // for evaluate()
		
		public static var gravity:Point2D = new Point2D(0, 9.8);
		
		public static var tA:Derivative = new Derivative();
		public static var tB:Derivative = new Derivative();
		public static var tC:Derivative = new Derivative();
		public static var tD:Derivative = new Derivative();

		protected var connectedTo:Particle;
		public var springForce:Number;
		public var length:Number;

		public function Particle(pos:Point2D, connectedTo:Particle=null, length:Number=0, springForce:Number=1) 
		{
			state = new State(pos);
			this.connectedTo = connectedTo;
			this.length = length;
			this.springForce = springForce;
		}
				
		internal function evaluate(initial:State, dt:Number, d:Derivative, dst:Derivative=null) : Derivative {
			if (dst == null) dst = new Derivative();
						
			initial.pos.addInto(d.dpos.scaleInto(dt, tempPoint), tempState.pos);
			initial.vel.addInto(d.dvel.scaleInto(dt, tempPoint), tempState.vel);
			
			dst.dpos.copyFrom(tempState.vel);
			dst.dvel.copyFrom(gravity);
			// spring force
			if (connectedTo != null) {
				if(length == 0) {
					tempPoint.copyFrom(connectedTo.state.pos).sub(initial.pos).scale(springForce);
					dst.dvel.add(tempPoint);
				} else {
					var dist:Number = connectedTo.state.pos.distance(initial.pos);
					tempPoint.copyFrom(connectedTo.state.pos).sub(initial.pos).scale(springForce*(1/dist)*(dist-length));
					dst.dvel.add(tempPoint);
				}
				tempPoint.copyFrom(connectedTo.state.vel).sub(initial.vel).scale(1);
				dst.dvel.add(tempPoint);
			}
			
			
			return dst;
		}
		
		internal function integrateStep(dt:Number) : void {
			evaluate(state, 0, tA.zero(), tA);
			evaluate(state, dt/2, tA, tB);
			evaluate(state, dt/2, tB, tC);
			evaluate(state, dt, tC, tD);
			
			state.pos.add( tB.dpos.addInto(tC.dpos, tempPoint).scale(2).add(tA.dpos).add(tD.dpos).scale(dt/6) );
			state.vel.add( tB.dvel.addInto(tC.dvel, tempPoint).scale(2).add(tA.dvel).add(tD.dvel).scale(dt/6) );
		}
		
		public function update() : void {
			if (state.pos.y > 100) {
				//state.vel.y = -Math.abs(state.vel.y);
			}
			
			integrateStep(1 / 10);
		}
	}
	
}