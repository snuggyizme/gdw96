shader_type canvas_item;

uniform vec2 scale;
uniform vec4 colourA : source_color;
uniform vec4 colourB : source_color;
uniform vec4 replaceColour : source_color;

void fragment() {
	if (distance(COLOR, replaceColour) > 0.1) {
		discard;
	}
	
	vec2 gridUV = UV * scale;
	vec2 cell = floor(gridUV);
	
	if (mod(cell.x + cell.y, 2.0) == 0.0) {
		COLOR = colourA;
	}
	else {
		COLOR = colourB;
	}
	
}