shader_type canvas_item;

uniform vec2 shadow_offset;
uniform float shadow_alpha;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    vec2 texture_size = vec2(TEXTURE_PIXEL_SIZE.x, TEXTURE_PIXEL_SIZE.y);
    
    vec2 shadow_uv = UV - shadow_offset / texture_size;
    vec4 shadow_color = texture(TEXTURE, shadow_uv);
    
    color.rgb = mix(color.rgb, shadow_color.rgb, shadow_alpha);
    
    COLOR = color;
}
