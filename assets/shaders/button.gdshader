shader_type canvas_item;


uniform sampler2D screen_texture: hint_screen_texture;
uniform sampler2D mask;


void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);
	float r = 1.0- color.r;
	float g = 1.0- color.g;
	float b = 1.0- color.b;
	float a = texture(mask, UV).a;
	COLOR = vec4(r, g, b, a);
}