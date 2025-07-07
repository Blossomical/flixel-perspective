package flixel.perspective;

import flixel.FlxBasic.IFlxBasic;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

interface IPerspectiveObject extends IFlxBasic
{
	public var z(default, set):Float;
	public var fov(default, set):Float;
	public var angleX(default, set):Float;
	public var angleY(default, set):Float;
	public var originZ:FlxPoint;
	
	public var useDepthColor(default, set):Bool;
	public var depthColor(default, set):FlxColor;
}

@:forward
@:coreType
abstract PerspectiveObject from PerspectiveSprite to PerspectiveSprite from PerspectiveText to PerspectiveSprite from IPerspectiveObject to PerspectiveObject
	from PerspectiveGroup to PerspectiveObject {}
	
