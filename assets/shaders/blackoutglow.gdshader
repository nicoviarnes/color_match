shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float glow_amount : hint_range(0.0, 1.0) = 0.1;
uniform float glow_radius : hint_range(0.0, 1.0) = 0.1;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    vec4 final_color = vec4(0.0, 0.0, 0.0, tex_color.a);

    // Calculate the glow color
    vec4 glow_color = color * glow_amount;

    // Calculate the glow effect based on distance from the sprite
    vec2 glow_offset = UV - vec2(0.5);
    float distance = length(glow_offset);
    float glow_factor = smoothstep(glow_radius, 0.0, distance);

    // Apply the glow effect
    final_color.rgb += glow_color.rgb * glow_factor;

    // Output the final color
    COLOR = final_color;
}
