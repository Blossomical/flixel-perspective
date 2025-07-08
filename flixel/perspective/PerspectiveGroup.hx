package flixel.perspective;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.perspective.IPerspectiveObject;
import flixel.perspective.PerspectiveSprite.IPerspectiveSprite;
import flixel.util.FlxColor;

class PerspectiveGroup extends FlxTypedSpriteGroup<PerspectiveObject> implements IPerspectiveObject
{
	public var z(default, set):Float = 0;
	
	public var fov(default, set):Float = 90;
	public var angleX(default, set):Float = 0;
	public var angleY(default, set):Float = 0;
	public var originZ:FlxPoint = FlxPoint.get();
	public var useDepthColor(default, set):Bool = false;
	public var depthColor(default, set):FlxColor = 0xFF000000;
	
	public var useGroupAngle(default, set):Bool = false;
	public var groupOrigin:FlxPoint = FlxPoint.get();
	public var groupAngles:FlxPoint = FlxPoint.get();
	public var groupZ(default, set):Float = 0;
	
	public function new(x:Float = 0, y:Float = 0, maxSize:Int = 0)
	{
		super(x, y, maxSize);
	}
	
	override public function update(elapsed:Float)
	{
		forEach(obj ->
		{
			if (useGroupAngle)
				obj.groupOrigin.set(groupOrigin.x, groupOrigin.y);
			else
				obj.groupOrigin.set((originZ.x /* + groupOrigin.x*/) + findMinX(), (originZ.y /* + groupOrigin.y*/) + findMinY());
			// if (gobj?.members != null)
			// 	gobj.groupOrigin.set(originZ.x + groupOrigin.x, originZ.y + groupOrigin.y);
			// FUCK idk how to handle group origin
		});
		// if (useGroupAngle)
		// 	forEach(obj ->
		// 	{
		// 		obj.groupAngles.set_x((angleX * FlxAngle.TO_RAD + (useGroupAngle ? groupAngles.x : 0)));
		// 		obj.groupAngles.set_y((angleY * FlxAngle.TO_RAD + (useGroupAngle ? groupAngles.y : 0)));
		// 	});
		super.update(elapsed);
	}
	
	override public function add(obj:PerspectiveObject):PerspectiveObject
	{
		var gobj:PerspectiveGroup = cast obj;
		// if (obj?.members == null)
		// 	obj.set_useGroupAngle(true);
		// else
		if (gobj?.members != null)
		{
			// Adding Groups to a Group is currently not fully supported
			gobj.set_useGroupAngle(true);
			super.add(gobj); // only wrote it twice because i'm still thinking of a way to handle groups properly
		}
		else
		{
			obj.set_useGroupAngle(true);
			super.add(obj);
		}
		return obj;
	}
	
	public function centerZOrigin()
	{
		originZ.set(width / 2, height / 2);
	}
	
	public function set_z(value:Float):Float
	{
		forEach(obj -> obj.set_groupZ(value /*+ (useGroupAngle ? groupZ : 0))*/));
		
		return z = value;
	}
	
	public function set_groupZ(value:Float):Float
	{
		forEach(obj -> obj.set_z(z + (useGroupAngle ? value : 0)));
		return groupZ = value;
	}
	
	public function set_fov(value:Float):Float
	{
		forEach(obj -> obj.set_fov(value));
		return fov = value;
	}
	
	private function set_angleX(value:Float):Float
	{
		forEach(obj ->
		{
			var gobj:PerspectiveGroup = cast obj;
			if (gobj?.members != null)
				gobj.set_angleX(value);
			else
				obj.groupAngles.set_x((value * FlxAngle.TO_RAD /*+ (useGroupAngle ? groupAngles.x : 0)*/));
		});
		return angleX = value;
	}
	
	private function set_angleY(value:Float):Float
	{
		forEach(obj ->
		{
			var gobj:PerspectiveGroup = cast obj;
			if (gobj?.members != null)
				gobj.set_angleY(value);
			else
				obj.groupAngles.set_y((value * FlxAngle.TO_RAD /*+ (useGroupAngle ? groupAngles.y : 0)*/));
		});
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
	
	public function set_useGroupAngle(value:Bool):Bool
		return useGroupAngle = value;
}
