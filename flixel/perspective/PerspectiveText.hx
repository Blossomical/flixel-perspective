package flixel.perspective;

import flixel.perspective.PerspectiveSprite;
import flixel.perspective.PerspectiveSprite.IPerspectiveSprite;
import flixel.text.FlxText;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.perspective.PerspectiveShader;
import flixel.perspective.IPerspectiveObject;

class PerspectiveText extends FlxText implements IPerspectiveSprite
{
	public static var gameDepth:Float = 720; // game dimensions: width * height * depth
	
	public var z(default, set):Float = 0;
	public var fov(default, set):Float = 90;
	public var angleX(default, set):Float = 0;
	public var angleY(default, set):Float = 0;
	public var originZ:FlxPoint = FlxPoint.get();
	
	public var useGroupAngle(default, set):Bool = false;
	public var groupOrigin:FlxPoint = FlxPoint.get();
	public var groupAngles:FlxPoint = FlxPoint.get();
	
	public var useDepthColor(default, set):Bool = false;
	public var depthColor(default, set):FlxColor = 0xFF000000;
	public var groupZ(default, set):Float = 0;
	
	public function new(X:Float = 0, Y:Float = 0, ?Z:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont = true)
	{
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
		shader = new PerspectiveShader();
		z = Z;
		fov = 90;
		angleX = 0;
		angleY = 0;
		useGroupAngle = false;
		centerZOrigin();
	}
	
	override public function drawComplex(camera:FlxCamera)
	{
		shader.data.centerOffset.value = [FlxG.width / 2 - originZ.x - x, FlxG.height / 2 - originZ.y - y];
		shader.data.groupOffset.value = [groupOrigin.x, groupOrigin.y];
		shader.data.groupAngle.value = [groupAngles.x, groupAngles.y];
		super.drawComplex(camera);
	}
	
	public inline function centerZOrigin():Void
		originZ.set(frameWidth * scale.x / 2, frameHeight * scale.y / 2);
		
	override public function updateHitbox():Void
	{
		super.updateHitbox();
		centerZOrigin();
	}
	
	public function set_z(z:Float):Float
	{
		this.shader.data.zCoord.value = [(z + groupZ) / gameDepth + 1];
		return this.z = z;
	}
	
	public function set_groupZ(z:Float):Float
	{
		this.shader.data.zCoord.value = [(this.z + z) / gameDepth + 1];
		return this.groupZ = z;
	}
	
	public function set_fov(fov:Float):Float
	{
		this.shader.data.fov.value = [fov * Math.PI / 180];
		return this.fov = fov;
	}
	
	public function set_angleX(angleX:Float):Float
	{
		this.shader.data.angleX.value = [angleX * Math.PI / 180];
		return this.angleX = angleX;
	}
	
	public function set_angleY(angleY:Float):Float
	{
		this.shader.data.angleY.value = [angleY * Math.PI / 180];
		return this.angleY = angleY;
	}
	
	public function set_useGroupAngle(v:Bool):Bool
	{
		shader.data.groupedAngle.value = [v];
		return this.useGroupAngle = v;
	}
	
	public function set_useDepthColor(useDepthColor:Bool):Bool
	{
		this.shader.data.useDepthColor.value = [useDepthColor];
		return this.useDepthColor = useDepthColor;
	}
	
	public function set_depthColor(depthColor:FlxColor):FlxColor
	{
		this.shader.data.depthColor.value = [depthColor.redFloat, depthColor.greenFloat, depthColor.blueFloat];
		return this.depthColor = depthColor;
	}
}
