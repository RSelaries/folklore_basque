shader_type spatial;

uniform vec3 color_low : source_color = vec3(1.0, 1.0, 0.0); // jaune
uniform vec3 color_high : source_color = vec3(1.0, 0.0, 0.0); // rouge

uniform float min_height = 0.0;
uniform float max_height = 2.0;

varying float local_y; // transmis du vertex au fragment

void vertex() {
    local_y = VERTEX.y; // hauteur locale du vertex
}

void fragment() {
    // normalisation entre 0 et 1
    float t = clamp((local_y - min_height) / (max_height - min_height), 0.0, 1.0);

    vec3 color = mix(color_low, color_high, t);
    ALBEDO = color;
}
