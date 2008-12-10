package fishgirl 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
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
		
		protected var sprite:Sprite;
		
		public var state:uint;
		
		internal var heart:DisplayObject;
		
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
				
			heart = new DancGraphics.heart();
			heart.y = - sprite.height - 20;
			heart.x = - heart.width/2;
			heart.visible = type == YELLOW;//false;
			addChild(heart);
			
			state = IDLE;
		}
		
		public function setState(state:uint) : void {
			this.state = state;
			
			heart.visible = (state == LOVING);			
		}
				
	}
	
}