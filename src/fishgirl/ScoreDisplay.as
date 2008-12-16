package fishgirl 
{
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class ScoreDisplay extends Sprite
	{
		private var tf:TextField, tfPoints:TextField;
		private var points:uint;
		private var tfmt:TextFormat;
		
		private var dropShadowFilter:DropShadowFilter;
		private var blurFilter:BlurFilter;
		
		public function ScoreDisplay() 
		{
			tfmt = new TextFormat("Verdana", 14, 0xFFFF00);
			tfmt.align = TextFormatAlign.RIGHT;

			dropShadowFilter = new DropShadowFilter(2, 45, 0, 1, 2, 2, 0.5);
			blurFilter = new BlurFilter();			

			tfPoints = new TextField();
			tfPoints.text = " points";
			tfPoints.setTextFormat(tfmt);
			tfPoints.autoSize = TextFieldAutoSize.RIGHT;
			tfPoints.x = -tfPoints.width;
			tfPoints.filters = [ dropShadowFilter ];
			
			tf = new TextField();
			tf.width = 200;
			tf.x = tfPoints.x-tf.width;
			tf.autoSize = TextFieldAutoSize.RIGHT;
			tf.setTextFormat(tfmt);
			tf.filters = [ dropShadowFilter ];
			
			addChild(tfPoints);	
			addChild(tf);	
			
			setScore(0);
		}
		
		public function update():void {
			var pts:uint = Main.game.points;
			if (points < pts) {
				setScore(points+1);
				tf.filters = [ dropShadowFilter, blurFilter ];
			} else if (points != pts) {
				setScore(pts);
			} else {
				if (tf.filters.length > 1)
					tf.filters = [ dropShadowFilter ];
			}
		}
		
		protected function setScore(score:uint) : void {
			points = score;
			tf.text = points.toString();// + " points";
			tf.setTextFormat(tfmt);
		}
	}
	
}