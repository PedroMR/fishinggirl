package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Backdrop extends Actor
	{	
		internal var actors:Array = [];
		
		public function Backdrop() 
		{
			var fg1:Sprite = new DancGraphics.FarGround1();
			var fg2:Sprite = new DancGraphics.FarGround2();
			var fg3:Sprite = new DancGraphics.FarGround3();
			var mg1:Sprite = new DancGraphics.MidGround1();
			var mg2:Sprite = new DancGraphics.MidGround2();
			var mg3:Sprite = new DancGraphics.MidGround3();
			var water:Sprite = new DancGraphics.waterbackground1();
			fg2.y = 100;
			mg2.y = 200;
			water.y = 300;
			addChild(fg1);
			addChild(mg2);
			addChild(water);
			
			this.scaleX = this.scaleY = 0.7;
			
			var b:Bird = new Bird();
			addChild(b);
			actors.push(b);
		}
		
		public override function update():void {
			for each(var a:Actor in actors) {
				a.update();
			}
		}
	}
	
}