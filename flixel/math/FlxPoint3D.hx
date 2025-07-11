package flixel.math;

import openfl.geom.Vector3D;

class FlxPoint3D extends Vector3D
{
	public function set(x:Float = 0, y:Float = 0, z:Float = 0)
	{
		setTo(x, y, z);
	}
}
