package fishgirl 
{
	
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
						rod.rotation += 15;
						rod.release();
						if (rod.rotation >= 0) {
							setState(IDLE);
							rod.rotation = 0;
						}
						break;
				}
			}
			
			rod.update();
		}
		
	}
	
}