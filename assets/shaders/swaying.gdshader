shader_type spatial;



// Maximum sway offset
uniform float sway_amount : hint_range(0.0, 1.0) = 0.1;
// Controls how tightly sway oscillates over the mesh's Y axis
uniform float sway_scale : hint_range(0.0, 10.0) = 1.0;
// Time (in seconds) for one full sway cycle
uniform float sway_duration : hint_range(0.01, 10.0) = 2.0;
// Direction of sway movement (X, Y, Z)
uniform vec3 sway_direction = vec3(1.0, 0.0, 0.0);


// Base color of the material (includes alpha)
uniform vec4 albedo_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);


void vertex() {
    // Calculate a normalized sway angle over time
    float sway_time = (TIME / sway_duration) * 6.28318; // 2π = full sine wave cycle

    // Calculate sway based on vertex height (Y)
    float sway = sin(VERTEX.y * sway_scale + sway_time) * sway_amount;

    // Apply sway in specified direction
    VERTEX.xyz += sway * sway_direction;
}


void fragment() {
    ALBEDO = albedo_color.rgb;
}