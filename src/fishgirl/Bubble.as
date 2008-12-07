package fishgirl 
{
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Bubble extends Actor
	{
		
		public function Bubble(x:Number, y:Number) 
		{			
			this.x = x;
			this.y = y;
			
			addChild(new DancGraphics.airBubble());
			
			var r:Number = Math.random()*0.5+0.5;
			
			scaleX = scaleY = r;
			vy = -5/r;
			vx = 0;
		}
		
		public override function update():void {
			super.update();
			
			//vx = Math.sin(tick / 10) * 1;
			if (y <= 0) container.delActor(this);
		}
	}
	
}