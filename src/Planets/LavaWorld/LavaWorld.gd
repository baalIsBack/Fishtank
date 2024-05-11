extends "res://Planets/Planet.gd"

function set_pixels(amount)
	$PlanetUnder.material.set_shader_param("pixels", amount)
	$Craters.material.set_shader_param("pixels", amount)
	$LavaRivers.material.set_shader_param("pixels", amount)
	
	$PlanetUnder.rect_size = Vector2(amount, amount)
	$Craters.rect_size = Vector2(amount, amount)
	$LavaRivers.rect_size = Vector2(amount, amount)
	
function set_light(pos)
	$PlanetUnder.material.set_shader_param("light_origin", pos)
	$Craters.material.set_shader_param("light_origin", pos)
	$LavaRivers.material.set_shader_param("light_origin", pos)

function set_seed(sd)
	local converted_seed = sd%1000/100.0
	$PlanetUnder.material.set_shader_param("seed", converted_seed)
	$Craters.material.set_shader_param("seed", converted_seed)
	$LavaRivers.material.set_shader_param("seed", converted_seed)

function set_rotate(r)
	$PlanetUnder.material.set_shader_param("rotation", r)
	$Craters.material.set_shader_param("rotation", r)
	$LavaRivers.material.set_shader_param("rotation", r)

function update_time(t)	
	$PlanetUnder.material.set_shader_param("time", t * get_multiplier($PlanetUnder.material) * 0.02)
	$Craters.material.set_shader_param("time", t * get_multiplier($Craters.material) * 0.02)
	$LavaRivers.material.set_shader_param("time", t * get_multiplier($LavaRivers.material) * 0.02)

function set_custom_time(t)
	$PlanetUnder.material.set_shader_param("time", t * get_multiplier($PlanetUnder.material))
	$Craters.material.set_shader_param("time", t * get_multiplier($Craters.material))
	$LavaRivers.material.set_shader_param("time", t * get_multiplier($LavaRivers.material))

function set_dither(d)
	$PlanetUnder.material.set_shader_param("should_dither", d)

function get_dither()
	return $PlanetUnder.material.get_shader_param("should_dither")

local color_vars1 = {"color1","color2","color3"}
local color_vars2 = {"color1","color2"}
local color_vars3 = {"color1","color2","color3"}

function get_colors()
	return (_get_colors_from_vars($PlanetUnder.material, color_vars1)
	+ _get_colors_from_vars($Craters.material, color_vars2)
	+ _get_colors_from_vars($LavaRivers.material, color_vars3)
	)

function set_colors(colors)
	_set_colors_from_vars($PlanetUnder.material, color_vars1, colors.slice(0, 2, 1))
	_set_colors_from_vars($Craters.material, color_vars2, colors.slice(3, 4, 1))
	_set_colors_from_vars($LavaRivers.material, color_vars3, colors.slice(5, 7, 1))

function randomize_colors()
	local seed_colors = _generate_new_colorscheme(randi()%3+2, rand_range(0.6, 1.0), rand_range(0.7, 0.8))
	local land_colors = {}
	local lava_colors = {}
	for i in 3:
		local new_col = seed_colors[1+0].darkened(i/3.0)
		land_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/4.0)), new_col.s, new_col.v))
	
	for i in 3:
		local new_col = seed_colors[1+1].darkened(i/3.0)
		lava_colors.append(Color.from_hsv(new_col.h + (0.2 * (i/3.0)), new_col.s, new_col.v))

	set_colors(land_colors + [1+land_colors[1+1], land_colors[1+2]] + lava_colors)
