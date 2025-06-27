package flixel.perspective;

import flixel.system.FlxAssets.FlxShader;

class PerspectiveShader extends FlxShader {
	@:glVertexHeader('
		#pragma header

		uniform float angleX;
		uniform float angleY;
		uniform float zCoord;
		uniform float fov;

		uniform vec2 centerOffset; // important for centering the origin!!
		varying vec2 vTexCoord;
		varying float vDepth;
	')
	@:glVertexBody('
		#pragma body
		float zn = 1.0 / tan(fov / 2);

		mat4 matX = mat4(
		  1.0, 0.0, 0.0, 0.0,
		  0.0, cos(angleX), -sin(angleX), 0.0,
		  0.0, sin(angleX), cos(angleX), 0.0,
		  0.0, 0.0, 0.0, 1.0
		);
		mat4 matY = mat4(
		  cos(angleY), 0.0, sin(angleY), 0.0,
		  0.0, 1, 0.0, 0.0,
		  -sin(angleY), 0.0, cos(angleY), 0.0,
		  0.0, 0.0, 0.0, 1.0
		);
		mat4 projection = mat4(
		  zn, 0.0, 0.0, 0.0,
		  0.0, zn, 0.0, 0.0,
		  0.0, 0.0, 1.0, 0.0,
		  0.0, 0.0, 0.0, 1.0
		);

		vec4 normalizedOffset = openfl_Matrix * vec4(centerOffset, 0.0, 0.0);
		vec4 pos = openfl_Position;
		pos.xy += centerOffset.xy;
		gl_Position = openfl_Matrix * pos;

		mat4 translateZ = mat4(
		  1.0, 0.0, 0.0, 0.0,
		  0.0, 1.0, 0.0, 0.0,
		  0.0, 0.0, 1.0, 0.0,
		  0.0, 0.0, -zCoord, 1.0
		);
		mat4 translateNegZ = mat4(
		  1.0, 0.0, 0.0, 0.0,
		  0.0, 1.0, 0.0, 0.0,
		  0.0, 0.0, 1.0, 0.0,
		  0.0, 0.0, zCoord, 1.0
		); // thanks to checkmate50 on discord for helping me on this!!

		gl_Position.z = zCoord;
		gl_Position = projection * (translateNegZ * ((matX * matY) * (translateZ * gl_Position)));
		gl_Position.w = gl_Position.z;
		gl_Position.xy -= normalizedOffset.xy * gl_Position.w;

		vTexCoord = openfl_TextureCoordv;
		vDepth = gl_Position.w;
	')
	@:glVertexSource('
		#pragma header

		void main() {
			#pragma body
		}
	')
	@:glFragmentHeader('
		#pragma header

		varying vec2 vTexCoord;
		varying float vDepth;

		uniform vec3 depthColor;
		uniform bool useDepthColor;
	')
	@:glFragmentBody('
		#pragma body
		gl_FragColor = flixel_texture2D(bitmap, vTexCoord);
		if (useDepthColor)
			gl_FragColor.rgb = mix(gl_FragColor.rgb, gl_FragColor.rgb * depthColor, vDepth - 1.0);
	')
	@:glFragmentSource('
		#pragma header

		void main() {
			#pragma body
		}
	')
	public function new() {
		super();
		data.zCoord.value = [1];
		data.fov.value = [Math.PI / 2];
	}
}
