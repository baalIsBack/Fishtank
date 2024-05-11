varying mediump vec4 var_position;
varying mediump vec3 var_normal;


uniform lowp vec4 tint;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    // Pre-multiply alpha since all runtime textures already are
    vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    vec4 color = texture2D(texture, texture_coords.xy) * tint_pm;
    return vec4(color.rgb,1.0);
}

