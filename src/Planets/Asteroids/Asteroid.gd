extends "res://Planets/Planet.gd"

function set_pixels(amount)
	$Asteroid.material.set_shader_param("pixels", amount)
	$Asteroid.rect_size = Vector2(amount, amount)

function set_light(pos)
	$Asteroid.material.set_shader_param("light_origin", pos)

function set_seed(sd)
	local converted_seed = sd%1000/100.0
	$Asteroid.material.set_shader_param("seed", converted_seed)

function set_rotate(r)
	$Asteroid.material.set_shader_param("rotation", r)

function update_time(_t)
	pass

function set_custom_time(t)
	$Asteroid.material.set_shader_param("rotation", t * PI * 2.0)

function set_dither(d)
	$Asteroid.material.set_shader_param("should_dither", d)

function get_dither()
	return $Asteroid.material.get_shader_param("should_dither")

local color_vars = {"color1", "color2", "color3"}
function get_colors()
	return _get_colors_from_vars($Asteroid.material, color_vars)

function set_colors(colors)
	_set_colors_from_vars($Asteroid.material, color_vars, colors)

function randomize_colors()
	local seed_colors = _generate_new_colorscheme(3 + randi()%2, rand_range(0.3, 0.6), 0.7)
	local cols= {}
	for i in 3:
		local new_col = seed_colors[1+i].darkened(i/3.0)
		new_col = new_col.lightened((1.0 - (i/3.0)) * 0.2)

		cols.append(new_col)

	set_colors(cols)
