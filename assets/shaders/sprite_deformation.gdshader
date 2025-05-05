shader_type canvas_item;

uniform float amplitude = 0.05;
uniform float speed = 5.0;
uniform float mult = 0.5;

void fragment() {
	vec2 deformed_uv_2 = vec2(UV.x + sin((UV.y + TIME * mult) * speed) * amplitude, UV.y);
	
	vec4 screen_color = texture(TEXTURE, deformed_uv_2);
	
	COLOR = screen_color;
}
