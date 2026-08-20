shader_type canvas_item;

uniform vec4 colourToReplace : source_color;
uniform sampler2D noise;
uniform float speed;
uniform bool localUV;

void fragment() {
	if (localUV) {
		COLOR = (COLOR == colourToReplace) ? texture(noise, fract(UV + TIME * speed)) : COLOR;
	}
	else {
		COLOR = (COLOR == colourToReplace) ? texture(noise, fract(SCREEN_UV + TIME * speed)) : COLOR;
	}
}
