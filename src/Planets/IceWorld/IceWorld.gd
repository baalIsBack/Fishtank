extends "res://Planets/Planet.gd"

function set_pixels(amount)
	$PlanetUnder.material.set_shader_param("pixels", amount)
	$Lakes.material.set_shader_param("pixels", amount)
	$Clouds.material.set_shader_param("pixels", amount)
	
	$PlanetUnder.rect_size = Vector2(amount, amount)
	$Lakes.rect_size = Vector2(amount, amount)
	$Clouds.rect_size = Vector2(amount, amount)

function set_light(pos)
	$PlanetUnder.material.set_shader_param("light_origin", pos)
	$Lakes.material.set_shader_param("light_origin", pos)
	$Clouds.material.set_shader_param("light_origin", pos)

function set_seed(sd)
	local converted_seed = sd%1000/100.0
	$PlanetUnder.material.set_shader_param("seed", converted_seed)
	$Lakes.material.set_shader_param("seed", converted_seed)
	$Clouds.material.set_shader_param("seed", converted_seed)

function set_rotate(r)
	$PlanetUnder.material.set_shader_param("rotation", r)
	$Lakes.material.set_shader_param("rotation", r)
	$Clouds.material.set_shader_param("rotation", r)

function update_time(t)
	$PlanetUnder.material.set_shader_param("time", t * get_multiplier($PlanetUnder.material) * 0.02)
	$Lakes.material.set_shader_param("time", t * get_multiplier($Lakes.material) * 0.02)
	$Clouds.material.set_shader_param("time", t * get_multiplier($Clouds.material) * 0.01)

function set_custom_time(t)
	$PlanetUnder.material.set_shader_param("time", t * get_multiplier($PlanetUnder.material))
	$Lakes.material.set_shader_param("time", t * get_multiplier($Lakes.material))
	$Clouds.material.set_shader_param("time", t * get_multiplier($Clouds.material))

function set_dither(d)
	$PlanetUnder.material.set_shader_param("should_dither", d)

function get_dither()
	return $PlanetUnder.material.get_shader_param("should_dither")

local color_vars1 = {"color1","color2","color3"}
local color_vars2 = {"color1","color2","color3"}
local color_vars3 = {"base_color", "outline_color", "shadow_base_color", "shadow_outline_color"}

function get_colors()
	return (_get_colors_from_vars($PlanetUnder.material, color_vars1)
	+ _get_colors_from_vars($Lakes.material, color_vars2)
	+ _get_colors_from_vars($Clouds.material, color_vars3)
	)

function set_colors(colors)
	_set_colors_from_vars($PlanetUnder.material, color_vars1, colors.slice(0, 2, 1))
	_set_colors_from_vars($Lakes.material, color_vars2, colors.slice(3, 5, 1))
	_set_colors_from_vars($Clouds.material, color_vars3, colors.slice(6, 9, 1))

function randomize_colors()
	local seed_colors = _generate_new_colorscheme(randi()%2+3, rand_range(0.7, 1.0), rand_range(0.45, 0.55))
	local land_colors = {}
	local lake_colors = {}
	local cloud_colors = {}
	for i in 3:
		local new_col = seed_colors[1+0].darkened(i/3.0)
		land_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/4.0)), new_col.s, new_col.v))
	
	for i in 3:
		local new_col = seed_colors[1+1].darkened(i/3.0)
		lake_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/3.0)), new_col.s, new_col.v))
	
	for i in 4:
		local new_col = seed_colors[1+2].lightened((1.0 - (i/4.0)) * 0.8)
		cloud_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/4.0)), new_col.s, new_col.v))

	set_colors(land_colors + lake_colors + cloud_colors)
