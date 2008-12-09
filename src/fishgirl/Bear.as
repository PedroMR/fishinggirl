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
		
		internal var sprite:Sprite;
		
		public var state:uint;
		
		internal var heart:DisplayObject;
		
		public var rod:FishingRod;
		
		public function Bear(type:uint)
		{
			var bgraphics:Array = [ DancGraphics.pinkBear, DancGraphics.yellowBear ];
			
			sprite = new bgraphics[type]();
			addChild(sprite);
			if (type == PINK) {
				// ref point already at bear's feet
				sprite.x = 0;
				sprite.y = 0;
				rod = new FishingRod();
				rod.x = 15;
				rod.y = -sprite.height /2;
				addChild(rod);
			} else {
				// gaah, Danc made the other bear with a different ref point. :)
				sprite.x = -sprite.width / 2;
				sprite.y = -sprite.height;
			}
			
			
			graphics.lineStyle(3, 0xFF0000);
			graphics.moveTo(0, -5);
			graphics.lineTo(0, 5);
			
			heart = new DancGraphics.heart();
			heart.y = - sprite.height - 20;
			heart.x = - heart.width/2;
			heart.visible = false;
			addChild(heart);
			
			state = IDLE;
		}
		
		public function setState(state:uint) : void {
			this.state = state;
			
			heart.visible = (state == LOVING);			
		}
		
		public override function update() : void {
			super.update();
			
			if (rod != null) {
				switch(state) {
					case CASTING:
						rod.rotation -= 2;
						if (rod.rotation <= -180) {
							setState(MISCAST);
						}
						break;
					case MISCAST:
						rod.rotation += 5;
						if (rod.rotation >= 0) {
							setState(IDLE);
							rod.rotation = 0;
						}
						break;
				}
			
				//if (Main.keysheld[81]) rod.rotation -= 1;			
				//if (Main.keysheld[65]) rod.rotation += 1;
			}
		}
		
	}
	
}