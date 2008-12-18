package fishgirl 
{
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class InfoDisplay extends Actor
	{
		private static var textFormat:TextFormat = new TextFormat( "Verdana", 16, 0xFFFF00, null, null, null, null, null, TextFormatAlign.CENTER );
		public static var world:World;
		
		protected var state:uint;
		protected var tf:TextField ;
		protected static const APPEARING:uint = 0, SHOWING:uint = 1, DISAPPEARING:uint = 2;
				
		public static function show(text:String, pt:Point) : InfoDisplay {
			var pg:Point = world.globalToLocal(pt);
			var id:InfoDisplay = new InfoDisplay(text, pg.x, pg.y);
			world.addActor(id);
			return id;
		}
		
		public function InfoDisplay(text:String, x:Number, y:Number) 
		{			
			tf = new TextField();
			tf.text = text;
			//tf.background = true;
			//tf.backgroundColor = 0xFFFFFF;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.setTextFormat(textFormat);
			addChild(tf);
			tf.width = tf.textWidth;
			tf.x = - tf.width / 2;
			this.x = x;
			this.y = y;
			this.alpha = 0;
			state = APPEARING;
		}
		
		public override function update() : void {
			super.update();
			
			switch(state) {
				case APPEARING:
					alpha += 0.1;
					if (alpha >= 1) state = SHOWING;
					break;
				case SHOWING:				
					if (tick >= 100) state = DISAPPEARING;
					break;
				case DISAPPEARING:					
					alpha -= 0.05;					
					if (alpha <= 0) {
						container.delActor(this);
					}
					break;
			}
			
		}
		
	}
	
}