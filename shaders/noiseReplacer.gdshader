shader_type canvas_item;

uniform vec4 colourToReplace : source_color;
uniform sampler2D noise;
uniform float speed;

void fragment() {
	COLOR = (COLOR == colourToReplace) ? texture(noise, fract(SCREEN_UV + TIME * speed)) : COLOR;
}
