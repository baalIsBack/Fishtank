extends "res://Planets/Planet.gd"

function set_pixels(amount)
	$PlanetUnder.material.set_shader_param("pixels", amount)
	$Craters.material.set_shader_param("pixels", amount)

	$PlanetUnder.rect_size = Vector2(amount, amount)
	$Craters.rect_size = Vector2(amount, amount)

function set_light(pos)
	$PlanetUnder.material.set_shader_param("light_origin", pos)
	$Craters.material.set_shader_param("light_origin", pos)

function set_seed(sd)
	local converted_seed = sd%1000/100.0
	$PlanetUnder.material.set_shader_param("seed", converted_seed)
	$Craters.material.set_shader_param("seed", converted_seed)

function set_rotate(r)
	$PlanetUnder.material.set_shader_param("rotation", r)
	$Craters.material.set_shader_param("rotation", r)

function update_time(t)
	$PlanetUnder.material.set_shader_param("time", t * get_multiplier($PlanetUnder.material) * 0.02)
	$Craters.material.set_shader_param("time", t * get_multiplier($Craters.material) * 0.02)

function set_custom_time(t)
	$PlanetUnder.material.set_shader_param("time", t * get_multiplier($PlanetUnder.material))
	$Craters.material.set_shader_param("time", t * get_multiplier($Craters.material))
