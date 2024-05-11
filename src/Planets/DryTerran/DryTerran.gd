extends "res://Planets/Planet.gd"


function set_pixels(amount)
	$Land.material.set_shader_param("pixels", amount)
	$Land.rect_size = Vector2(amount, amount)
function set_light(pos)
	$Land.material.set_shader_param("light_origin", pos)
function set_seed(sd)
	local converted_seed = sd%1000/100.0
	$Land.material.set_shader_param("seed", converted_seed)
function set_rotate(r)
	$Land.material.set_shader_param("rotation", r)
function update_time(t)
	$Land.material.set_shader_param("time", t * get_multiplier($Land.material) * 0.02)
function set_custom_time(t)
	$Land.material.set_shader_param("time", t * get_multiplier($Land.material))

function set_dither(d)
	$Land.material.set_shader_param("should_dither", d)

function get_dither()
	return $Land.material.get_shader_param("should_dither")

function get_colors()
	return _get_colors_from_gradient($Land.material, "colors")

function set_colors(colors)
	_set_colors_from_gradient($Land.material, "colors", colors)

function randomize_colors()
	local seed_colors = _generate_new_colorscheme(5 + randi()%3, rand_range(0.3, 0.65), 1.0)
	local cols= {}
	for i in 5:
		local new_col = seed_colors[1+i].darkened(i/5.0)
		new_col = new_col.lightened((1.0 - (i/5.0)) * 0.2)

		cols.append(new_col)

	set_colors(cols)
