package fishgirl 
{
	import flash.geom.Point;
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
		public var player:FishingBear;
		public var groupie:Bear;
		
		internal var camera:Camera;
		
		public function World() 
		{
			Fish.world = this;
			
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
			
			player = new FishingBear(Bear.PINK, ocean);
			player.x = ocean.x;
			player.y = town.y;
			addActor(player);
			
			groupie = new Bear(Bear.YELLOW);
			groupie.x = player.x - 100;
			groupie.y = player.y;
			addActor(groupie);

			camera = new Camera(this);
			
		}

		public function findLureIn(x1:Number, y1:Number, x2:Number, y2:Number) : Lure {
			var lure:Lure = player.rod.lure;
			if (lure.size == Lure.NONE) 
				return null;
			/*
			var pt:Point = new Point(lure.x, lure.y);
			pt = player.rod.localToGlobal(pt);
			pt = ocean.globalToLocal(pt);
			if (pt.x > x1 && pt.x < x2 && pt.y > y1 && pt.y < y2)
			*/
			if (lure.oceanX > x1 && lure.oceanX < x2 && lure.oceanY > y1 && lure.oceanY < y2)
				return player.rod.lure;
			else
				return null;
		}
		
		public override function update() : void {
			//if (Main.keysheld[65]) camera.setTarget(Ocean.MIN_X, 0);
			
			camera.updateKeys(Main.keysheld[Keyboard.LEFT], Main.keysheld[Keyboard.UP], Main.keysheld[Keyboard.RIGHT], Main.keysheld[Keyboard.DOWN], Keyboard.capsLock?1:2);
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