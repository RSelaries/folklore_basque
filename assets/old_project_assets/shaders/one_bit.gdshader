shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float exposition_mult = 4.0;

const float quantization_steps = 10.0;

void fragment() {
	vec4 screen_color = texture(screen_texture, UV) * exposition_mult;
	
	float bw_color = (screen_color.r * 0.299) + (screen_color.g * 0.587) + (screen_color.b * 0.114);
		
	float quantized_bw_color = floor(bw_color * quantization_steps) / quantization_steps; 
	
	COLOR = vec4(vec3(quantized_bw_color), 1.0);
}
