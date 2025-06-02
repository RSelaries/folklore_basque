shader_type spatial;
render_mode cull_disabled, unshaded;


uniform sampler2D texture;
uniform float outline_width = 0.0;
uniform vec3 outline_color: source_color;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 texture_color = texture(texture, UV);
	
	if (UV.x <= 0.0 + outline_width || UV.x >= 1.0 - outline_width ||
	UV.y <= 0.0 + outline_width || UV.y >= 1.0 - outline_width)
	{	
		ALBEDO = outline_color;
	} else {
		ALBEDO = texture_color.rgb * 1.5;
	}
}
