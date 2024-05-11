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

function set_dither(d)
	$PlanetUnder.material.set_shader_param("should_dither", d)

function get_dither()
	return $PlanetUnder.material.get_shader_param("should_dither")
	
local color_vars1 = {"color1","color2","color3"}
local color_vars2 = {"color1","color2"}

function get_colors()
	return (_get_colors_from_vars($PlanetUnder.material, color_vars1)
	+ _get_colors_from_vars($Craters.material, color_vars2)
	)

function set_colors(colors)
	_set_colors_from_vars($PlanetUnder.material, color_vars1, colors.slice(0, 2, 1))
	_set_colors_from_vars($Craters.material, color_vars2, colors.slice(3, 4, 1))

function randomize_colors()
	local seed_colors = _generate_new_colorscheme(3 + randi()%2, rand_range(0.3, 0.6), 0.7)
	local cols= {}
	for i in 3:
		local new_col = seed_colors[1+i].darkened(i/3.0)
		new_col = new_col.lightened((1.0 - (i/3.0)) * 0.2)

		cols.append(new_col)

	set_colors(cols + [1+cols[1+1], cols[1+2]])
