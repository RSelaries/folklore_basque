shader_type spatial;

uniform bool warp_ScreenSpace = false;
uniform sampler2D texture_albedo : source_color, filter_nearest;

uniform float warp_step : hint_range(0.0, 1.0) = 1.0;
uniform float warp_mult = 1.0;
uniform float opacity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	vec2 uv = vec2(0.0);
	
	if(warp_ScreenSpace){
		uv = SCREEN_UV;
	}else{
		uv = UV;
	}
	
	// TWEAK THE COEFFS AND/OR EQUATION FOR A DIFFERENT WARP PATTERN
	uv.x += sin(uv.y * 1.54 * warp_mult * PI + TIME) * cos(uv.y * 1.31 * warp_mult * PI + TIME) * 0.1; 
	uv.y += cos(uv.x * 1.74 * warp_mult * PI + TIME) * -sin(uv.y * 1.64 * warp_mult * PI + TIME) * 0.1;
	
	uv.x = mix(UV.x, uv.x, warp_step);
	uv.y = mix(UV.y, uv.y, warp_step);
	
	vec4 color = texture(texture_albedo, uv);
	
	ALBEDO = color.rgb;
}