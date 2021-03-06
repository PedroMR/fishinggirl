﻿package fishgirl 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class Actor extends Sprite
	{		
		public static var nActors:uint = 0;
		
		public var container:ActorContainer;
		protected var tick:uint;
		protected var vx:Number, vy:Number;
		
		/**
		 * z=1 means the object is in the fore plane, i.e., camera movement is 1:1.
		 * Larger zs divide camera movement proportionally.
		 */
		public var z:Number;
		
		public var worldX:Number, worldY:Number;
		
		public function Actor(spr:Sprite=null) 
		{
			tick = 0;
			z = 1;
			vx = 0;
			vy = 0;
			worldX = 0;
			worldY = 0;
			if(spr != null) addChild(spr);
		}
		
		public function setVelocity( vx:Number, vy:Number ) : void {
			this.vx = vx;
			this.vy = vy
		}
		
		public function moveCamera( dx:Number, dy:Number ) : void {
			this.x -= dx / z;
			this.y -= dy / z;
		}
		
		public function update() : void 
		{
			nActors++;
			tick++;
			
			x += vx / z;
			y += vy / z;
			worldX += vx;
			worldY += vy;
		}
		
		public function setPosition(worldX:Number, worldY:Number) : void {
			this.worldX = worldX;
			this.worldY = worldY;
		}
	}
	
}