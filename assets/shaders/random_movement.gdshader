shader_type canvas_item;


uniform bool type_switch = true;
uniform float movement_step : hint_range(0.0, 1.0) = 1.0;


float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}


void vertex() {
	float rdm_nbr = random(VERTEX * 1.0);

	vec2 vertex_mov;

	if(type_switch) {
		vertex_mov = vec2(sin(sin(TIME * 2.0) * 10.0 * rdm_nbr) * 50.0 * movement_step, cos(cos(TIME * 2.0) * 10.0 * rdm_nbr) * 50.0)  * movement_step;
	} else  {
		vertex_mov = vec2(sin(TIME * 10.0 * rdm_nbr) * 50.0  * movement_step, cos(TIME * 10.0 * rdm_nbr) * 50.0)  * movement_step;
	}

	vertex_mov = mix(VERTEX, vertex_mov, movement_step);

	VERTEX += vertex_mov;
}
