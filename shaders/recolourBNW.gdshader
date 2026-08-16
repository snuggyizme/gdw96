shader_type canvas_item;

uniform sampler2D gradient;

void fragment() {
	COLOR = COLOR.a > 0.5 ? texture(gradient, vec2(COLOR.r)) : COLOR;
}
