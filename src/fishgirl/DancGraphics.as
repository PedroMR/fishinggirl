package fishgirl 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Pedro Miller Rabinovitch <pedromr at gmail>
	 */
	public class DancGraphics 
	{
		[Embed(source = '../../res/FishingGirl.swf')]
		[Bindable]
		internal var dancSWFClass : Class;
		[Embed(source = '../../res/background.png')] public static var background:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'FarGround1')] public static var FarGround1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'FarGround2')] public static var FarGround2:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'cloud1')] public static var cloud1:Class;
		
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'MidGround3')] public static var MidGround3:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'MidGround2')] public static var MidGround2:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'MidGround1')] public static var MidGround1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'FarGround3')] public static var FarGround3:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'waterbackground1')] public static var waterbackground1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'water1')] public static var water1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'trophyForest2')] public static var trophyForest2:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'trophyForest1')] public static var trophyForest1:Class;
		
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishVeryLarge1')] public static var fishVeryLarge1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishSmall4')] public static var fishSmall4:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishSmall3')] public static var fishSmall3:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishSmall2')] public static var fishSmall2:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishSmall1')] public static var fishSmall1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishMedium4')] public static var fishMedium4:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishMedium3')] public static var fishMedium3:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishMedium2')] public static var fishMedium2:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishMedium1')] public static var fishMedium1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishLarge4')] public static var fishLarge4:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishLarge3')] public static var fishLarge3:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishLarge2')] public static var fishLarge2:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishLarge1')] public static var fishLarge1:Class;
		
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'fishingRod')] public static var fishingRod:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'lureSmall')] public static var lureSmall:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'lureMedium')] public static var lureMedium:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'lureLarge')] public static var lureLarge:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'lureBomb')] public static var lureBomb:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'SpeachBubble')] public static var SpeachBubble:Class;
		
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'airBubble')] public static var airBubble:Class;
		
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'topper2x1')] public static var topper2x1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'topper1x1')] public static var topper1x1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'trophyHouse2')] public static var trophyHouse2:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'trophyHouse1x1')] public static var trophyHouse1x1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'Sun')] public static var Sun:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'Grass1')] public static var Grass1:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'MidTree')] public static var MidTree:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'MidTree2')] public static var MidTree2:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'FarTree')] public static var FarTree:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'FarTree2')] public static var FarTree2:Class;
		
		
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'characterPinkBear')] public static var pinkBear:Class;
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'characterYellowBear')] public static var yellowBear:Class;
		
		
		[Embed(source = '../../res/FishingGirl.swf', symbol = 'Bird')] public static var bird:Class;
		
		internal function traceInto(obj:Object, pref:String) : void {
			if (obj is DisplayObjectContainer) {
				var mc:DisplayObjectContainer = obj as DisplayObjectContainer;
				trace(pref+mc.name+" ("+mc.numChildren+")");
				var n:int = mc.numChildren-1;
				while (n >= 0) {
					traceInto(mc.getChildAt(n), pref + "  ");
					n--;
				}
			} else if (obj is DisplayObject) {
				trace(pref+(obj as DisplayObject).name);
			} else {
				trace(pref + "...and something");
			}
			
		}
		
	}
	
}