package fishgirl 
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Backdrop extends ActorContainer
	{	
		internal var far:ActorContainer;
		internal var mid:ActorContainer;		
		
		public function Backdrop() 
		{
			var sky:Sprite = new Sprite();
			sky.graphics.beginGradientFill(GradientType.LINEAR, [0x73BFFD, 0x0000FF], null, [12, 255], Util.newRotate(-Math.PI / 2));
			sky.graphics.drawRect(0, 0, 2000, 400);
			sky.graphics.endFill();
			addChild(sky);
			
			far = new ActorContainer();
			var xx:Number;
			var a:Actor;
			var i:uint = 0;
			far.z = 24;
			far.y += 0;
			addActor(far);
			for (xx = -250; xx < 3000; xx += a.width) {
				a = new Mountain(Mountain.FAR, (i++) % 3, xx, 0);
				far.addActor(a);
				
				//for (var j:uint = 0; j < 30; j++ ) (a as Mountain).addTree();
			}

			mid = new ActorContainer();
			i = 0;
			for (xx = -250; xx < 3000; xx += a.width) {
				a = new Mountain(Mountain.MIDDLE, (i++)%3, xx, 0);
				mid.addActor(a);
			}
			mid.z = 8;
			mid.y += 200;
			addActor(mid);			
			
			/**
			
			var i:uint = 0;
			
			var xx:Number;
			xx = -250;
			i = 0;
			for each(var spr:Sprite in far) {
				spr.x = xx;
				spr.y = fary[i++];
				xx += spr.width;
				
				addChild(spr);
			}
			xx = -250;
			i = 0;
			for each(spr in mid) {
				spr.x = xx;
				spr.y = midy[i++];
				xx += spr.width;				
				addChild(spr);
			}
			/*
			addChild(new DancGraphics.background());
			/**/
			//this.scaleX = this.scaleY = 0.7;

			addActor(new Bird());
		}
		
		public override function update():void {
			/*
			var bg:Sprite = mid[2] as Sprite;
			if (Main.keysheld[87]) {
				bg.y -= Keyboard.capsLock ? 1 : 10;
				trace(bg.y);
			} else if (Main.keysheld[83]) {
				bg.y += Keyboard.capsLock ? 1 : 10;
				trace(bg.y);
			}
			*/
			super.update();
		}
		
		public override function moveCamera(dx:Number, dy:Number) : void {
			for each( var a:Actor in actors ) {
				a.moveCamera(dx, dy);
			}
		}
		
	}
	
	
}