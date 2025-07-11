# flixel-perspective
3D Rotation system for FlxSprites and FlxTexts with perspective and depth

# EXAMPLE USAGE:
```hx
text = new PerspectiveText(0, 0, 0, 0, 'Hello World', 50);
add(text.screenCenter());
text.useDepthColor = true;
text.depthColor = 0xFF150523;
//
text.z += FlxG.mouse.wheel * 3;
text.angleY += (FlxG.keys.pressed.D ? 1 : (FlxG.keys.pressed.A ? -1 : 0));
text.angleX += (FlxG.keys.pressed.S ? 1 : (FlxG.keys.pressed.W ? -1 : 0));
```
https://github.com/user-attachments/assets/d6a161a0-cfc1-44fa-b30c-86428b9e22ca

```hx
sprite = new PerspectiveSprite(0);
add(sprite.loadGraphic('assets/images/missing').screenCenter());
sprite.screenCenter();
sprite.useDepthColor = true;
//
sprite.z += FlxG.mouse.wheel * 3;
sprite.angleY += (FlxG.keys.pressed.D ? 1 : (FlxG.keys.pressed.A ? -1 : 0));
sprite.angleX += (FlxG.keys.pressed.S ? 1 : (FlxG.keys.pressed.W ? -1 : 0));
```
https://github.com/user-attachments/assets/fcb34b56-3b13-4fc0-bd5a-bf4c837f85f1
