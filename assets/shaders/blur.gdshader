shader_type canvas_item;

uniform float lod: hint_range(0.0, 5) = 0.0;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

void fragment(){
	float alpha = COLOR.a;
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, lod);
	if (COLOR.r < 0.01) {
		COLOR = color * 0.4;
		COLOR.a = 1.0;
	}
	else {
		COLOR = color + COLOR;
	}
}