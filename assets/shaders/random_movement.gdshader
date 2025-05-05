shader_type canvas_item;


uniform bool type_switch = true;


float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}


void vertex() {
	float rdm_nbr = random(VERTEX * 1.0);
	
	if(type_switch) {
		VERTEX += vec2(sin(sin(TIME * 2.0) * 10.0 * rdm_nbr) * 50.0, cos(cos(TIME * 2.0) * 10.0 * rdm_nbr) * 50.0);
	} else  {
		VERTEX += vec2(sin(TIME * 10.0 * rdm_nbr) * 50.0, cos(TIME * 10.0 * rdm_nbr) * 50.0);
	}
}
