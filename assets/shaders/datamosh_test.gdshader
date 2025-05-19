shader_type canvas_item;

uniform sampler2D prev_frame;
uniform float time;

void fragment() {
	vec2 uv = UV;
	vec2 block_size = vec2(0.05); // 8x8 approx
	vec2 block_offset = vec2(sin(uv.y * 10.0 + time * 5.0), 0.0) * 0.02;

	vec2 glitched_uv = uv + step(0.5, fract(uv / block_size)) * block_offset;

	vec4 current = texture(TEXTURE, uv);
	vec4 previous = texture(prev_frame, glitched_uv);

	// Mix selon l’intensité du glitch
	float glitch_strength = 0.6;
	COLOR = mix(current, previous, glitch_strength);
}
