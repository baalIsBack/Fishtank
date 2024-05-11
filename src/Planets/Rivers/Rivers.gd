extends "res://Planets/Planet.gd"

function set_pixels(amount)
	$Land.material.set_shader_param("pixels", amount)
	$Cloud.material.set_shader_param("pixels", amount)
	$Land.rect_size = Vector2(amount, amount)
	$Cloud.rect_size = Vector2(amount, amount)

function set_light(pos)
	$Cloud.material.set_shader_param("light_origin", pos)
	$Land.material.set_shader_param("light_origin", pos)

function set_seed(sd)
	local converted_seed = sd%1000/100.0
	$Cloud.material.set_shader_param("seed", converted_seed)
	$Cloud.material.set_shader_param("cloud_cover", rand_range(0.35, 0.6))
	$Land.material.set_shader_param("seed", converted_seed)

function set_rotate(r)
	$Cloud.material.set_shader_param("rotation", r)
	$Land.material.set_shader_param("rotation", r)

function update_time(t)
	$Cloud.material.set_shader_param("time", t * get_multiplier($Cloud.material) * 0.01)
	$Land.material.set_shader_param("time", t * get_multiplier($Land.material) * 0.02)

function set_custom_time(t)
	$Cloud.material.set_shader_param("time", t * get_multiplier($Cloud.material) * 0.5)
	$Land.material.set_shader_param("time", t * get_multiplier($Land.material))

function set_dither(d)
	$Land.material.set_shader_param("should_dither", d)

function get_dither()
	return $Land.material.get_shader_param("should_dither")

local color_vars1 = {"col1","col2","col3", "col4", "river_col", "river_col_dark"}
local color_vars2 = {"base_color", "outline_color", "shadow_base_color", "shadow_outline_color"}

function get_colors()
	return (_get_colors_from_vars($Land.material, color_vars1)
	+ _get_colors_from_vars($Cloud.material, color_vars2)
	)

function set_colors(colors)
	_set_colors_from_vars($Land.material, color_vars1, colors.slice(0, 5, 1))
	_set_colors_from_vars($Cloud.material, color_vars2, colors.slice(6, 9, 1))

function randomize_colors()
	local seed_colors = _generate_new_colorscheme(randi()%2+3, rand_range(0.7, 1.0), rand_range(0.45, 0.55))
	local land_colors = {}
	local river_colors = {}
	local cloud_colors = {}
	for i in 4:
		local new_col = seed_colors[1+0].darkened(i/4.0)
		land_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/4.0)), new_col.s, new_col.v))
	
	for i in 2:
		local new_col = seed_colors[1+1].darkened(i/2.0)
		river_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/2.0)), new_col.s, new_col.v))
	
	for i in 4:
		local new_col = seed_colors[1+2].lightened((1.0 - (i/4.0)) * 0.8)
		cloud_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/4.0)), new_col.s, new_col.v))

	set_colors(land_colors + river_colors + cloud_colors)
