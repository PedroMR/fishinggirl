package fishgirl 
{
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class FishingBear extends Bear
	{
		protected var rod:FishingRod;		
		
		public function FishingBear(type:uint) 
		{
			super(type);
			rod = new FishingRod();
			rod.x = 15;
			rod.y = -sprite.height /2;
			addChild(rod);
		}
		
		public override function update() : void {
			super.update();
			
			if (rod != null) {
				switch(state) {
					case CASTING:
						rod.rotation -= 2;
						if (rod.rotation <= -180) {
							setState(MISCAST);
						}
						break;
					case MISCAST:
						rod.rotation += 5;
						if (rod.rotation >= 0) {
							setState(IDLE);
							rod.rotation = 0;
						}
						break;
				}
			
				//if (Main.keysheld[81]) rod.rotation -= 1;			
				//if (Main.keysheld[65]) rod.rotation += 1;
			}
		}
		
	}
	
}