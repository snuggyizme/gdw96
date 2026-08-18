shader_type canvas_item;

uniform sampler2D noise;
uniform sampler2D a;
uniform sampler2D b;
uniform bool aOrB;
uniform float speed;

void fragment() {
	vec2 value = vec2(texture(noise, fract(SCREEN_UV + TIME * speed)).r, 69.420);
	COLOR = aOrB ? texture(b, value) : texture(a, value);
}
