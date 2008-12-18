package fishgirl 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Bear extends Actor
	{
		public static const PINK:uint = 0;
		public static const YELLOW:uint = 1;
		
		public static const IDLE:uint = 0;
		public static const CASTING:uint = 1;
		public static const FISHING:uint = 2;
		public static const JUMPING:uint = 3;
		public static const LOVING:uint = 4;
		public static const MISCAST:uint = 5;
		public static const PREPARING_CAST:uint = 6;
		
		protected var sprite:Sprite;
		
		public var state:uint;
		
		protected var ticksInState:uint;
		
		internal var heart:DisplayObject;
		internal var speechBubble:Sprite;
		
		public function Bear(type:uint)
		{
			var bgraphics:Array = [ DancGraphics.pinkBear, DancGraphics.yellowBear ];
			
			sprite = new bgraphics[type]();
			addChild(sprite);
			if (type == PINK) {
				// ref point already at bear's feet
				sprite.x = 0;
				sprite.y = 0;
			} else {
				// gaah, Danc made the other bear with a different ref point. :)
				sprite.x = -sprite.width / 2;
				sprite.y = -sprite.height;
			}

			var rect:Rectangle = sprite.getBounds(this);
			
			speechBubble = new DancGraphics.speechBubble();
			speechBubble.y = rect.top - speechBubble.height - 10;
			speechBubble.x = rect.left - 14;
			//addChild(speechBubble);		
			
			heart = new DancGraphics.heart();
			heart.y = rect.top - heart.height - 5;
			heart.x = rect.left + rect.width/2 - heart.width/2;
			heart.visible = false;			
			addChild(heart);
						
			setState(IDLE);
		}
		
		public function setState(state:uint) : void {
			ticksInState = 0;
			this.state = state;
			
			heart.visible = (state == LOVING);
			
			if (state == LOVING) {
				
			}
		}
		
		
		public override function update() : void {
			super.update();
			ticksInState++;
			
			if (state == LOVING) {
				heart.scaleX = heart.scaleY = 1 + 0.2 * Math.sin(ticksInState/4);
				if (ticksInState > 100)
					setState(IDLE);
			}
		}
	}
	
}