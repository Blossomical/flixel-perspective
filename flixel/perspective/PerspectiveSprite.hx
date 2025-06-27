package flixel.perspective;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.perspective.PerspectiveShader;
import flixel.FlxSprite;
import flixel.perspective.IPerspectiveObject;

class PerspectiveSprite extends FlxSprite implements IPerspectiveObject
{
	public static var gameDepth:Float = 720; // game dimensions: width * height * depth

	public var z(default, set):Float = 0;
	public var fov(default, set):Float = 90;
	public var angleX(default, set):Float = 0;
	public var angleY(default, set):Float = 0;
	public var originZ:FlxPoint = FlxPoint.get();

	public var useDepthColor(default, set):Bool = false;
	public var depthColor(default, set):FlxColor = 0xFF000000;

	public function new(X:Float = 0, Y:Float = 0, Z:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		shader = new PerspectiveShader();
		z = Z;
		fov = 90;
		angleX = 0;
		angleY = 0;
		centerZOrigin();
	}

	override public function makeGraphic(width:Int, height:Int, color:FlxColor = FlxColor.WHITE, unique:Bool = false, ?key:Null<String>):FlxSprite
	{
		super.makeGraphic(width, height, color, unique, key);
		centerZOrigin();
		return this;
	}

	override public function loadGraphic(graphic:FlxGraphicAsset, animated:Bool = false, frameWidth:Int = 0, frameHeight:Int = 0, unique:Bool = false,
			?key:Null<String>):FlxSprite
	{
		super.loadGraphic(graphic, animated, frameWidth, frameHeight, unique, key);
		centerZOrigin();
		return this;
	}

	override public function drawComplex(camera:FlxCamera)
	{
		shader.data.centerOffset.value = [FlxG.width / 2 - originZ.x - x, FlxG.height / 2 - originZ.y - y]; // it's better to do this in drawComplex than overriding a bunch of functions
		super.drawComplex(camera);
	}

	public inline function centerZOrigin():Void
		originZ.set(frameWidth * scale.x / 2, frameHeight * scale.y / 2); // must update hitbox first when using makeGraphic

	override public function updateHitbox():Void
	{
		super.updateHitbox();
		centerZOrigin();
	}

	private function set_z(z:Float):Float
	{
		this.shader.data.zCoord.value = [z / gameDepth + 1];
		return this.z = z;
	}

	private function set_fov(fov:Float):Float
	{
		this.shader.data.fov.value = [fov * Math.PI / 180];
		return this.fov = fov;
	}

	private function set_angleX(angleX:Float):Float
	{
		this.shader.data.angleX.value = [angleX * Math.PI / 180];
		return this.angleX = angleX;
	}

	private function set_angleY(angleY:Float):Float
	{
		this.shader.data.angleY.value = [angleY * Math.PI / 180];
		return this.angleY = angleY;
	}

	private function set_useDepthColor(useDepthColor:Bool):Bool
	{
		this.shader.data.useDepthColor.value = [useDepthColor];
		return this.useDepthColor = useDepthColor;
	}

	private function set_depthColor(depthColor:FlxColor):FlxColor
	{
		this.shader.data.depthColor.value = [depthColor.redFloat, depthColor.greenFloat, depthColor.blueFloat];
		return this.depthColor = depthColor;
	}
}
