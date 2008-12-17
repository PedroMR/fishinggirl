package fishgirl 
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Ocean extends ActorContainer
	{
		public static const MIN_X:Number = 0;
		public static const MAX_X:Number = 1500;
		public static const MAX_DEPTH:Number = 1400;
		
		public static const depthRanges:Array = [ 
			[ 0.10, 0.35 ],
			[ 0.25, 0.50 ],
			[ 0.40, 0.70 ],
			[ 0.75, 1.00 ],
		];
		
		public function Ocean() 
		{
			//addChild(new DancGraphics.waterbackground1());
			var back:Sprite = new Sprite();
			addChild(back);
		
			var num:uint = 4;
			for (var i:int = 0; i < Fish.NUM_TYPES; i++ ) {
				for (var j:int = 0; j < num; j++)
					spawn(i);
					
				if ((i + 1) % (Fish.NUM_TYPES_PER_SIZE - 1) == 0)
					num--;
			}
				
			//graphics.beginFill(0x000040);
//			var mat:Matrix = new Matrix(); mat.rotate(Math.PI / 2);
			var graphics:Graphics = back.graphics;
			graphics.beginGradientFill(GradientType.LINEAR, [ 0x0080FF, 0x004080, 0x001060, 0x000030 ], [0.7,0.8,0.9,1], [0, 255/3, 2*255/3, 255], Util.newRotate(Math.PI/2));
			graphics.drawRect(MIN_X, 0, MAX_X, MAX_DEPTH);
			graphics.endFill();
		}
		
		public function spawn(type:uint) : Fish
		{
			var f:Fish = new Fish(type);
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
			if (tick % 16*4096 == 0) 
			{
				//addActor(new Bubble(Math.random() * (MAX_X - MIN_X) + MIN_X, Math.random() * 200 + MAX_DEPTH));
			}
		}
	}
	
}