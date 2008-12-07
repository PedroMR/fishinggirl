package fishgirl 
{
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class ActorContainer extends Actor
	{
		protected var actors:Array;
		
		public function ActorContainer() 
		{
			actors = [];
		}
		
		public function addActor( a : Actor ) : void {
			addChild(a);
			actors.push(a);
		}
		
		public override function update() : void {
			for each( var a:Actor in actors ) {
				a.update();
			}
		}
	}
	
}