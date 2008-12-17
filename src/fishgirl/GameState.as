package fishgirl 
{
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class GameState 
	{
		public static const STARTING:uint = 0;
		public static const READY_TO_CAST:uint = 1;
		public static const CASTING:uint = 2;
		public static const FISHING:uint = 3;
		public static const SCORING:uint = 4;
		public static const MISCAST:uint = 5;
		
		public var state:uint;
		public var points:uint;
		public var ticksInState:uint;
		
		public function GameState() 
		{
			points = 0;
			state = STARTING;
		}
		
	}
	
}