shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
void fragment() {
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);

    vec3 c = color.rgb;

    // Original → new
    if (distance(c, vec3(0.180, 0.188, 0.216)) < 0.05) {
        c = vec3(0.0);                         // 2e3037 → 000000
    }
    else if (distance(c, vec3(0.922, 0.898, 0.808)) < 0.05) {
        c = vec3(0.608, 0.737, 0.059);        // ebe5ce → 9bbc0f
    }
    else if (distance(c, vec3(0.122, 0.596, 0.906)) < 0.05) {
        c = vec3(0.545, 0.675, 0.059);        // 1f98e7 → 8bac0f
    }
    else if (distance(c, vec3(1.0, 0.780, 0.110)) < 0.05) {
        c = vec3(0.188, 0.384, 0.188);        // ffc71c → 306230
    }
    else if (distance(c, vec3(0.875, 0.035, 0.310)) < 0.05) {
        c = vec3(0.059, 0.220, 0.059);        // df094f → 0f380f
    }

    COLOR = vec4(c, color.a);
}