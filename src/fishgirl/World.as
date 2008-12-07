package fishgirl 
{
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class World extends ActorContainer
	{
		public var ocean:Ocean;
		public var backdrop:Backdrop;
		
		internal var camera:Camera;
		
		public function World() 
		{
			camera = new Camera(this);
			
			backdrop = new Backdrop();
			addChild(backdrop);
			
			ocean = new Ocean;
			ocean.y = 600;
			ocean.x = 100;
			ocean.scaleX = ocean.scaleY = 1;
			addChild(ocean);
			
		}
		
		public override function update() : void {
			/*
			var vel_cam:Number = Keyboard.capsLock ? 5 : 20;
			var dx:Number = 0, dy:Number = 0;
			if (Main.keysheld[Keyboard.LEFT]) dx -= vel_cam;
			if (Main.keysheld[Keyboard.RIGHT]) dx += vel_cam;
			if (Main.keysheld[Keyboard.UP]) dy -= vel_cam;
			if (Main.keysheld[Keyboard.DOWN]) dy += vel_cam;
			if (dx != 0 || dy != 0) {
				backdrop.moveCamera(dx, dy);
				ocean.moveCamera(dx, dy);
			}
			*/
			
			camera.update(Main.keysheld[Keyboard.LEFT], Main.keysheld[Keyboard.UP], Main.keysheld[Keyboard.RIGHT], Main.keysheld[Keyboard.DOWN], Keyboard.capsLock?1:2);
			backdrop.update();
			ocean.update();

		}
		
		public override function moveCamera(dx:Number, dy:Number) : void {
			if (dx != 0 || dy != 0) {
				backdrop.moveCamera(dx, dy);
				ocean.moveCamera(dx, dy);
			}
		}
	}
	
}