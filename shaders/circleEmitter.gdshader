shader_type canvas_item;

uniform float frequency = 1.0;
uniform float speed = 1.0;
uniform float thickness = 1.0;
uniform float softness = 1.0;
uniform float maxRadius = 1.0;
uniform vec4 ringColour : source_color;

void fragment() {
	vec2 centredUV = UV * 2.0 - 1.0;
	float dist = length(centredUV);
	float waveTimeline = (dist * frequency) - (TIME * speed);
	float repeatingWave = fract(waveTimeline);
	float ring = smoothstep(thickness, thickness - softness, repeatingWave);
	float edgeFade = smoothstep(maxRadius, maxRadius - 0.1, dist);
	float finalMask = ring * edgeFade;
	
	COLOR = vec4(ringColour.rgb, finalMask * ringColour.a);
}