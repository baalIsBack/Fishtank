


uniform float pixels = 100.0; //hint_range(10,100)

uniform sampler2D colorscheme;
uniform vec4 black_color : hint_color = vec4(0.0);

uniform float radius = 0.5; //hint_range(0.0,0.5)
uniform float light_width = 0.05; //hint_range(0.0, 0.5)


vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords){
	// pixelize uv
	vec2 uv = floor(texture_coords*pixels)/pixels;
	
	// distance from center
	float d_to_center = distance(uv, vec2(0.5));
	
	vec4 col = black_color;
	
	if (d_to_center > radius - light_width) {
		float col_val = ceil(d_to_center-(radius - (light_width * 0.5))) * (1.0/(light_width * 0.5));
		col = Texel(colorscheme, vec2(col_val, 0.0));
	}
	
	float a = step(d_to_center, radius);
	
	return vec4(col.rgb, a * col.a);
}
