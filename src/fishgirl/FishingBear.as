package fishgirl 
{
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class FishingBear extends Bear
	{
		public var rod:FishingRod;		
		
		public function FishingBear(type:uint, ocean:Ocean) 
		{
			super(type);
			rod = new FishingRod(ocean);
			rod.x = 15;
			rod.y = -sprite.height /2;
			addChild(rod);
			swapChildren(rod, sprite);
		}
		
		public override function update() : void {
			super.update();
			
			if (rod != null) {
				switch(state) {
					case PREPARING_CAST:
						rod.rotation -= 2;
						rod.lure.thrown = false;
						if (rod.rotation <= -180) {
							setState(MISCAST);							
						}
						break;
					case MISCAST:
						rod.rotation += 7;
						if (rod.rotation >= 0) {
							setState(IDLE);
							rod.rotation = 0;
						}
						break;
					case CASTING:
						if (rod.rotation < -15)					
							rod.rotation += Main.keysheld[Keyboard.SHIFT] ? 15 : 15;
						else
							rod.rotation = -15;
						
						rod.release();
							
						if (rod.line.freed == rod.line.segments - 1 || rod.lure.oceanY >= 2)
							setState(IDLE);
						break;
				}
			}
			
			rod.update();
		}
		
	}
	
}