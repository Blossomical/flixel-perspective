package flixel.perspective;

import flixel.math.FlxAngle;
import objects.PerspectiveText;
import objects.PerspectiveSprite;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.perspective.PerspectiveSprite.IPerspectiveSprite;
import flixel.perspective.IPerspectiveObject;
import flixel.group.FlxSpriteGroup;

class PerspectiveGroup extends FlxTypedSpriteGroup<PerspectiveObject>
{
	public var z(default, set):Float = 0;
	
	public var fov(default, set):Float = 90;
	public var angleX(default, set):Float = 0;
	public var angleY(default, set):Float = 0;
	public var originZ:FlxPoint = FlxPoint.get();
	public var useDepthColor(default, set):Bool = false;
	public var depthColor(default, set):FlxColor = 0xFF000000;
	
	override public function update(elapsed:Float)
	{
		forEach(obj -> obj.groupOrigin.set(FlxG.width / 2 - findMinX() - originZ.x, FlxG.height / 2 - findMinY() - originZ.y));
		super.update(elapsed);
	}
	
	override public function add(obj:PerspectiveObject):PerspectiveObject
	{
		super.add(obj);
		obj.set_useGroupAngle(true);
		return obj;
	}
	
	public function centerZOrigin()
	{
		originZ.set(width / 2, height / 2);
	}
	
	public function set_z(value:Float):Float
	{
		forEach(obj -> obj.set_groupZ(value));
		
		return z = value;
	}
	
	public function set_fov(value:Float):Float
	{
		forEach(obj -> obj.set_fov(value * FlxAngle.TO_RAD));
		return fov = value;
	}
	
	private function set_angleX(value:Float):Float
	{
		forEach(obj -> obj.groupAngles.x = value * FlxAngle.TO_RAD);
		return angleX = value;
	}
	
	private function set_angleY(value:Float):Float
	{
		forEach(obj -> obj.groupAngles.y = value * FlxAngle.TO_RAD);
		return angleY = value;
	}
	
	public function set_depthColor(value:FlxColor):FlxColor
	{
		forEach(obj -> obj.set_depthColor(value));
		return depthColor = value;
	}
	
	public function set_useDepthColor(value:Bool):Bool
	{
		forEach(obj -> obj.set_useDepthColor(value));
		return useDepthColor = value;
	}
}
