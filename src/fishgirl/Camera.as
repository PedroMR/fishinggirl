package fishgirl 
{
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Camera 
	{		
		internal var world:World;
		internal var vx:Number, vy:Number;
		
		internal var x:Number, y:Number;
		
		internal var targetX:Number, targetY:Number, has_target:Boolean;
		
		public static const X_MIN:Number = -600;
		public static const X_MAX:Number = Ocean.MAX_X-800;
		public static const Y_MIN:Number = -100;
		public static const Y_MAX:Number = Ocean.MAX_DEPTH - 100;
		
		protected var following:Actor, followingOffsetX:Number, followingOffsetY:Number;
		
		private var dbg:TextField;
		
		public function Camera(world:World) 
		{
			following = null;
			x = y = vx = vy = followingOffsetX = followingOffsetY = 0;
			this.world = world;
			has_target = false;
			dbg = new TextField();
			dbg.x = 0; dbg.y = 0; dbg.width = 500;
			world.addChild(dbg);
		}
	
		public function setTarget(targetX:Number, targetY:Number):void {
			this.targetX = targetX;
			this.targetY = targetY;
			has_target = true;
		}
		
		public function setTargetCentre(cx:Number, cy:Number):void {
			setTarget(cx - world.stage.stageWidth/2 + x, cy - world.stage.stageHeight/2 + y);
		}
		
		public function setTargetCentreOn(act:Actor, ox:Number, oy:Number) : void {
			var p:Point = new Point(act.x + ox, act.y + oy);
			var p2:Point = act.parent.localToGlobal(p);
			setTargetCentre(p2.x, p2.y);
		}
		
		public function followTarget(act:Actor, ox:Number = 0, oy:Number = 0) : void {
			trace("set follow " + act);
			following = act;
			followingOffsetX = ox;
			followingOffsetY = oy;
		}
		
		public function stopFollowing() : void {
			trace("stop fol");
			following = null;
		}
		
		public function update():void {
			if (following) {
				setTargetCentreOn(following, followingOffsetX, followingOffsetY);
			}
			
			var inc:Number = 0.3;
			var max:Number = 40;
			
			var dx:Number = targetX - x;
			var dy:Number = targetY - y;
			var right:Boolean = dx > 0;

			var px:Number = x + Math.abs(vx)*vx/(2*inc); // only for inc == 1
			var py:Number = y + Math.abs(vy)*vy/(2*inc); // only for inc == 1
			
			//dbg.text = "x " + x + " px " + px + " tx " + targetX + " vx "+vx+" f "+following;
			
			if (Math.abs(dx) < inc) {
				vx = 0;
				x = targetX;
				if (y == targetY) has_target = false;				
			} else if (right) {
				if (px < targetX - 2 * vx) {
					vx += ((px < targetX - 8*vx)? 3 : 1 ) * inc;
				}
				else if (px >= targetX - 2*vx) { vx -=  inc; if (vx < 0) vx = 0; }
			} else {
				if (px > targetX + 2*vx) vx -= ((px > targetX + 8*vx)? 3 : 1 ) * inc;
				else if (px <= targetX + 2*vx) { vx +=  inc; if (vx > 0) vx = 0; }
			}
				
			if (Math.abs(dy) < inc) {
				vy = 0;
				y = targetY;
				if (x == targetX) has_target = false;				
			} else if (dy>0) {
				if (py < targetY - 2*vy) vy += ((py < targetY - 8*vy)? 3 : 1 ) * inc;
				else { vy -=  inc; if (vy < 0) vy = 0; }
			} else {
				if (py > targetY + 2*vy) vy -= ((py > targetY + 8*vy)? 3 : 1 ) * inc;
				else { vy +=  inc; if (vy > 0) vy = 0; }
			}
				
			if (vx < -max) vx = -max;
			else if (vx > max) vx = max;
			if (vy < -max) vy = -max;
			else if (vy > max) vy = max;
			
		}
		
		public function updateKeys(left:Boolean, up:Boolean, right:Boolean, down:Boolean, turbo:Number) : void {
			dbg.text = "t? "+has_target;
			
			if (has_target || following) {
				update();
			} else {
				var inc:Number = 1*turbo;
				var max:Number = 10*turbo;
				
				if (left) vx -= inc; 
				else if (right) vx += inc;
				else if (vx < 0) vx += inc;
				else if (vx > 0) vx -= inc;
				
				if (up) vy -= inc; 
				else if (down) vy += inc;
				else if (vy < 0) vy += inc;
				else if (vy > 0) vy -= inc;
				
				if (vx < -max) vx = -max;
				else if (vx > max) vx = max;
				if (vy < -max) vy = -max;
				else if (vy > max) vy = max;			
			}
			
			if (x + vx < X_MIN) vx = X_MIN - x;
			if (x + vx > X_MAX) vx = X_MAX - x;
			if (y + vy < Y_MIN) vy = Y_MIN - y;
			if (y + vy > Y_MAX) vy = Y_MAX - y;
			
			x += vx;
			y += vy;
			
			world.moveCamera(vx, vy);
		}
	}
	
}