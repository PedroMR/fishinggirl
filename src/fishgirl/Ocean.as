package fishgirl 
{
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Ocean extends ActorContainer
	{
		
		public function Ocean() 
		{
			addChild(new DancGraphics.waterbackground1());
			
			addFish(new Fish());
		}
		
		public function addFish(f:Fish) : void {
			addActor(f);
			f.x = 30;
			f.y = 80;
		}
		
		public override function update() : void {
			super.update();
			
			// update water
		}
	}
	
}