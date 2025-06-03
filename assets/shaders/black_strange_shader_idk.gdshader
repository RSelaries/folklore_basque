shader_type spatial;
render_mode unshaded;


void fragment() {
	float color = UV.y * 4.0;
	color = clamp(color, 0.0, 1.0);
	
	ALBEDO = vec3(0.0);
	
	ALPHA = 0.8 * color;
	
}
