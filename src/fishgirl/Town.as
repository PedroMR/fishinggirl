package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Town extends Actor
	{
		public static const EDGE_X:Number = 120;
		
		internal var cliff:Sprite;
		
		public function Town() 
		{
			var cliffColor:uint = 0x454550;
			cliff = new Sprite();
			cliff.graphics.beginFill(cliffColor);
			var wid:Number = 1200, margin:Number=20;
			cliff.graphics.drawRect( -wid, 0, wid, Ocean.MAX_DEPTH);
			cliff.graphics.endFill();
			cliff.graphics.beginFill(cliffColor);
			cliff.graphics.drawRoundRect(-wid-margin, 0, wid+2*margin, 30, margin/2);
			cliff.graphics.endFill();
			
			
			var houses:Array = [
				DancGraphics.trophyForest1, DancGraphics.trophyForest2, DancGraphics.trophyHouse1x1, DancGraphics.trophyHouse2,
			];
			var offy:Array = [ 80, 10, 5, 85 ];
			
			for (var i:uint = 0; i < 7; i++) {
				var id:uint = Math.random() * houses.length;
				var building:Sprite = new (houses[id] as Class)();
				var padding:Number = 80;
				//building.x = Math.random() * (wid - 2 * padding) + padding - wid;
				building.x = (i/7+Math.random()/7) * (wid - 2 * padding) + padding - wid;
				building.y = -building.height + offy[id];
				addChild(building);
			}
			
			addChild(cliff);			
		}
		
		public override function update() : void {
			super.update();
			//if (Main.keysheld[87]) y += 10;
		}
		
		public override function moveCamera(dx:Number, dy:Number) : void {
			super.moveCamera(dx, dy);
		}
	}
	
}