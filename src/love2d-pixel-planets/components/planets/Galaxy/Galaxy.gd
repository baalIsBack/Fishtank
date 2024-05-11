extends "res://Planets/Planet.gd"

function set_pixels(amount)
	$Galaxy.material.set_shader_param("pixels", amount)
	$Galaxy.rect_size = Vector2(amount, amount) 

end
function set_light(pos)
	pass

end
function set_seed(sd)
	local converted_seed = sd%1000/100.0
	$Galaxy.material.set_shader_param("seed", converted_seed)

end
function set_rotate(r)
	$Galaxy.material.set_shader_param("rotation", r)

end
function update_time(t)
	$Galaxy.material.set_shader_param("time", t * get_multiplier($Galaxy.material) * 0.04)

end
function set_custom_time(t)
	$Galaxy.material.set_shader_param("time", t * PI * 2 * $Galaxy.material.get_shader_param("time_speed"))

end
function set_dither(d)
	$Galaxy.material.set_shader_param("should_dither", d)

end
function get_dither()
	return $Galaxy.material.get_shader_param("should_dither")

end
function get_colors()
	return _get_colors_from_gradient($Galaxy.material, "colorscheme")

end
function set_colors(colors)
	_set_colors_from_gradient($Galaxy.material, "colorscheme", colors)

end
function randomize_colors()
	local seed_colors = _generate_new_colorscheme(6 , rand_range(0.5,0.8), 1.4)
	local cols = {}
	for i in 6:
		local new_col = seed_colors[1+i].darkened(i/7.0)
		new_col = new_col.lightened((1.0 - (i/6.0)) * 0.6)
		cols.append(new_col)

end
	set_colors(cols)
