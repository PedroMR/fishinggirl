﻿package fishgirl 
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Backdrop extends ActorContainer
	{	
		private static const NUM_BIRDS:uint = 14;
		
		internal var far:ActorContainer;
		internal var mid:ActorContainer;		
		
		public function Backdrop() 
		{
			var sky:Sprite = new Sprite();
			sky.graphics.beginGradientFill(GradientType.LINEAR, [0xC2E3FE, 0x03ABFC], null, [12, 255], Util.newRotate(-Math.PI / 2));
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
			
			for (var j:uint = 0; j < 150; j++) {
				var cloud:Sprite = new DancGraphics.cloud1();
				var ac:Actor = new Actor(cloud);
				addActor(ac);
				//cloud.alpha = Util.randomAround(0.9, 0.2);
				ac.z = Math.random() * far.z + 7;
				ac.scaleY = 8 / ac.z;
				ac.scaleX = ac.scaleY * (0.9 + Math.random() * 0.2);
				ac.y = Math.random() * 200 - 100; ac.x = Math.random() * 1500 - 300;
				ac.transform.colorTransform = Util.brightnessTransform(Util.randomAround(1, 0.2));
				
				var cloud2:Sprite = new DancGraphics.cloud1();
				var ac2:Actor = new Actor(cloud2);
				addActor(ac2);
				//cloud2.alpha = cloud.alpha;
				ac2.x = ac.x;
				ac2.z = ac.z + 0.12;
				ac2.scaleY = ac.scaleY * 1.002;
				ac2.scaleX = ac.scaleX * 1.002;
				ac2.y = ac.y+2;
				ac2.transform.colorTransform = Util.brightnessTransform(Util.randomAround(0.6, 0.2));
				
				
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
			

			for (i = 0; i < NUM_BIRDS; i++)
				addActor(new Bird());

			sortActors();
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