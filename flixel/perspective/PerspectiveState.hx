package flixel.perspective;

import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.perspective.PerspectiveSprite;
import flixel.perspective.IPerspectiveObject;

class PerspectiveState extends FlxState
{
	override public function draw():Void
	{
		@:privateAccess final oldDefaultCameras = FlxCamera._defaultCameras;
		if (_cameras != null)
		{
			@:privateAccess FlxCamera._defaultCameras = _cameras;
		}
		
		members.sort((b1, b2) ->
		{
			var b1:IPerspectiveObject = cast b1;
			var b2:IPerspectiveObject = cast b2;
			
			var z1:Float = (b1?.z ?? 1);
			var z2:Float = (b2?.z ?? 1);
			
			z1 = z1 + Math.cos(FlxAngle.asRadians(b1?.angleX ?? 0)) * Math.cos(FlxAngle.asRadians(b1?.angleY ?? 0)) * (b1?.originZ?.z ?? 0);
			z2 = z2 + Math.cos(FlxAngle.asRadians(b2?.angleX ?? 0)) * Math.cos(FlxAngle.asRadians(b2?.angleY ?? 0)) * (b2?.originZ?.z ?? 0);
			trace(z1 + ' : ' + z2);
			return Std.int(z2 - z1);
		});
		for (basic in members)
		{
			if (basic != null && basic.exists && basic.visible)
				basic.draw();
		}
		
		@:privateAccess FlxCamera._defaultCameras = oldDefaultCameras;
	}
}
