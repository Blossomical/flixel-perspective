package flixel.perspective;

import flixel.util.FlxColor;
import flixel.math.FlxPoint;

interface IPerspectiveObject
{
	public var z(default, set):Float;
	public var fov(default, set):Float;
	public var angleX(default, set):Float;
	public var angleY(default, set):Float;
	public var originZ:FlxPoint;

	public var useDepthColor(default, set):Bool;
	public var depthColor(default, set):FlxColor;
}
