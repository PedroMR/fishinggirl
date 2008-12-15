package fishgirl 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Fish extends Actor
	{
		internal static var world:World;
		
		internal var sprite:Sprite;
		
		internal var target:Point;
		
		private var lure:Lure;
		private var ticksInState:uint;
		
		protected var chaseSpeed:Number;
		
		public var type:uint, size:uint;
		
		public static const IDLE:uint = 0;
		public static const WATCHING:uint = 1;
		public static const CHASING:uint = 2;
		internal var state:uint;
		
		internal static const VEL_FLIP_CHANGE:Number = -0.15;
		internal static const DSCALE_FLIP_CHANGE:Number = 0.20;
		internal static const VELOCITY_INCREASE:Number = 0.1;
		internal static const VELOCITY_MAX:Number = 5;
		
		public static const SMALL:uint = 0;
		public static const MEDIUM:uint = 1;
		public static const LARGE:uint = 2;
		public static const VERY_LARGE:uint = 3;
		
		internal static const sprites:Array = [
			DancGraphics.fishSmall1, DancGraphics.fishSmall2, DancGraphics.fishSmall3, DancGraphics.fishSmall4, 
			DancGraphics.fishMedium1, DancGraphics.fishMedium2, DancGraphics.fishMedium3, DancGraphics.fishMedium4, 
			DancGraphics.fishLarge1, DancGraphics.fishLarge2, DancGraphics.fishLarge3, DancGraphics.fishLarge4, 
			DancGraphics.fishVeryLarge1,
		];
		
		public function Fish() 
		{
			tick = Math.random() * 1024;
			
			setState(IDLE);
			
			type = Math.random() * 13;
			size = type / 4;
						
			sprite = new sprites[type]();
			//sprite.x = -sprite.width / 2;
			//if (size == MEDIUM) sprite.x = -sprite.width;
			//else if (size == LARGE) sprite.x = -sprite.width / 2;
			sprite.y = 0//-sprite.height / 2;
			addChild(sprite);
			
			setVelocity(0, 0);
			target = new Point(x + 150, y);
			
			scaleX = scaleY = Math.random() * 0.3 + 0.85;
			
		}
		
		public function setState(s:uint) : void {
			if (state == s)
				return;
			state = s;
			ticksInState = 0;
			switch(state) {
				case IDLE:
					rotation = 0;
					break;
				case CHASING:
					chaseSpeed = 0;
					break;
			}
		}
		
		public override function update() : void 
		{
			ticksInState++;
			switch(state) {
			case IDLE:
				checkLure();
				updateIdle();
				break;
			case WATCHING:
				updateWatch();
				checkLure();
				break;
			case CHASING:
				updateChase();
				checkLure();
				break;
			}
				
		}
		
		public function updateChase() : void {
			chaseSpeed += 0.1;
			var dx:Number = lure.oceanX - x;
			var dy:Number = lure.oceanY - y;
			var alpha:Number = Math.atan2(dy, dx);	
			if (sprite.scaleX > 0) alpha = Math.PI+alpha;
			rotation = 180 * alpha/ Math.PI;
			vx = chaseSpeed * Math.cos(alpha);
			vy = chaseSpeed * Math.sin(alpha);
			/*
			graphics.clear();
			graphics.lineStyle(0, 0xFF0000);
			graphics.moveTo(0, 0);
			graphics.lineTo(vx, vy);
			*/
			super.update();
		}
		
		public function updateWatch() : void {
			vx = 0;
			updateBobbing();			
			super.update();
			var dx:Number = lure.oceanX - x;
			var dy:Number = lure.oceanY - y;
			
			var alpha:Number = Math.atan2(dy, dx);
			if (sprite.scaleX > 0) alpha = Math.PI+alpha;
			rotation = 180 * alpha/ Math.PI;
			/*
			graphics.clear();
			graphics.lineStyle(0, 0xFF0000);
			graphics.moveTo(0, 0);
			graphics.lineTo(dx, dy);
			*/
			
			if (ticksInState > 10) 
				setState(CHASING);
		}
		
		public function checkLure() : void {
			var dx1:Number = state==IDLE ? 5 : -5;
			var dx2:Number = state==IDLE ? 100 : 200;
			var dy1:Number = state==IDLE ? -30 : -100;
			var dy2:Number = state==IDLE ? 30 : 100;
			
			var x1:Number, x2:Number, y1:Number, y2:Number;
			
			if (sprite.scaleX < 0) {				
				x1 = x + dx1; x2 = x + dx2;
			} else {
				x1 = x - dx2; x2 = x - dx1;
			}
			y1 = y + dy1; y2 = y + dy2;
			/*
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(0, 0xFFFFFF);
			g.drawRect(x1 - x, y1 - y, x2 - x1, y2 - y1);
			g.drawCircle(0, 0, 3);
			*/
			var lure:Lure = world.findLureIn(x1, y1, x2, y2);
			if (lure) {
				if (state == IDLE) {
					setState(WATCHING);				
					this.lure = lure;
				}
			} else {
				setState(IDLE);
				this.lure = null;
			}
		}
		
		public function updateBobbing() : void {
			vy = Math.sin(tick / 5) * 0.5;
		}
		public function updateIdle() : void 
		{
			var dx:Number = target.x - x;
			var dy:Number = target.y - y;
			
			updateBobbing();
			
			if (dx > 0) {				
				if (vx < VELOCITY_MAX) {
					vx += VELOCITY_INCREASE;
					if (vx > VELOCITY_MAX)
						vx = VELOCITY_MAX;
				}
				
				super.update();
				
				if (target.x <= x) {
					chooseTarget();
				}
			} else {
				if (vx > -VELOCITY_MAX) {
					vx -= VELOCITY_INCREASE;
					if (vx < -VELOCITY_MAX)
						vx = -VELOCITY_MAX;
				}
				
				super.update();
				
				if (target.x >= x) {
					chooseTarget();
				}
			}
			if ((vx > VEL_FLIP_CHANGE && sprite.scaleX > -1)) {
				sprite.scaleX -= DSCALE_FLIP_CHANGE;
			} else if ((vx < VEL_FLIP_CHANGE && sprite.scaleX < 1)) {
				sprite.scaleX += DSCALE_FLIP_CHANGE;
			}
			
			/*
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(3, 0xFF00FF);
			g.moveTo(0, 0);
			g.lineTo((scaleX/Math.abs(scaleX))*dx, dy);
			*/
		}
		
		public function chooseTarget() : void {
			target = new Point( Math.random() * (Ocean.MAX_X-Ocean.MIN_X+600) + Ocean.MIN_X - 300, y );
		}
		
	}
	
}