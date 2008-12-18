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
			if (a.container != null) {
				a.container.delActor(a);
			}
			addChild(a);
			actors.push(a);
			a.container = this;
		}
		
		public function delActor( a : Actor ) : void {
			var pos:uint = actors.indexOf(a);
			if(pos != -1) 
				actors.splice(pos, 1);
				
			removeChild(a);
		}
		
		public override function update() : void {
			tick++;
			for each( var a:Actor in actors ) {
				a.update();
			}
		}		
		
		public function sortActors() : void {
			var changed:Boolean = false;
			do {				
				changed = false;
				for ( var i:uint = 0; i < actors.length-1; ++i ) {
					if (actors[i].z < actors[i + 1].z) {
						swapChildren( actors[i], actors[i + 1] );
						var a:Actor = actors[i + 1];
						actors[i + 1] = actors[i];
						actors[i] = a;
						changed = true;
					}
				}
			} while (changed);
		}
	}
	
}