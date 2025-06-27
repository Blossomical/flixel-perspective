package flixel.perspective;

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
			
			return Std.int((b2?.z ?? 1) - (b1?.z ?? 1));
		});
		for (basic in members)
		{
			if (basic != null && basic.exists && basic.visible)
				basic.draw();
		}
		
		@:privateAccess FlxCamera._defaultCameras = oldDefaultCameras;
	}
}
