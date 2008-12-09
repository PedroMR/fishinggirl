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
		public var town:Town;
		public var player:Bear;
		public var groupie:Bear;
		
		internal var camera:Camera;
		
		public function World() 
		{
			camera = new Camera(this);
			
			backdrop = new Backdrop();
			addActor(backdrop);
			
			ocean = new Ocean;
			ocean.y = 600;
			ocean.x = 100;
			ocean.scaleX = ocean.scaleY = 1;
			addActor(ocean);
			
			town = new Town();
			town.y = ocean.y - 20;
			town.x = ocean.x;
			addActor(town);
			
			player = new Bear(Bear.PINK);
			player.x = ocean.x;
			player.y = town.y;
			addActor(player);
			
			groupie = new Bear(Bear.YELLOW);
			groupie.x = player.x - 100;
			groupie.y = player.y;
			addActor(groupie);
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
			super.update(); // update actors
		}
		
		public override function moveCamera(dx:Number, dy:Number) : void {
			if (dx != 0 || dy != 0) {
				for each (var a:Actor in actors)
					a.moveCamera(dx, dy);
			}
		}
	}
	
}