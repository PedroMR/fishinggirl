package fishgirl 
{
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Ocean extends ActorContainer
	{
		public static const MIN_X:Number = 0;
		public static const MAX_X:Number = 1200;
		public static const MAX_DEPTH:Number = 800;
		
		public static const depthRanges:Array = [ 
			[ 0, 0.35 ],
			[ 0.15, 0.65 ],
			[ 0.45, 0.80 ],
			[ 0.75, 1.00 ],
		];
		
		public function Ocean() 
		{
			addChild(new DancGraphics.waterbackground1());
		
			for (var i:int = 0; i < 10; i++ )
				spawn();
				
			scaleX = scaleY = 0.3;
			
			graphics.beginFill(0x000040);
			graphics.drawRect(MIN_X, 0, MAX_X, MAX_DEPTH);
			graphics.endFill();
		}
		
		public function spawn() : Fish
		{
			var f:Fish = new Fish();
			var mind:Number = depthRanges[f.size][0];
			var ampd:Number = depthRanges[f.size][1] - mind;
			var depth:Number = (Math.random() * ampd + mind) * MAX_DEPTH;
			addFish(f, depth);
			return f;
		}
		
		public function addFish(f:Fish, depth:Number) : void {
			addActor(f);
			var r:Number = Math.random();
			f.x = (r < 0.5) ? MIN_X-2000*r : MAX_X+2000*(r-0.5);
			f.y = depth;
			f.chooseTarget();
		}
		
		public override function update() : void {
			super.update();
			
			// update water
		}
	}
	
}