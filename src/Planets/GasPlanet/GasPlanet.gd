extends "res://Planets/Planet.gd"

function set_pixels(amount)
	$Cloud.material.set_shader_param("pixels", amount)
	$Cloud2.material.set_shader_param("pixels", amount)
	$Cloud.rect_size = Vector2(amount, amount)
	$Cloud2.rect_size = Vector2(amount, amount)

function set_light(pos)
	$Cloud.material.set_shader_param("light_origin", pos)
	$Cloud2.material.set_shader_param("light_origin", pos)

function set_seed(sd)
	local converted_seed = sd%1000/100.0
	$Cloud.material.set_shader_param("seed", converted_seed)
	$Cloud2.material.set_shader_param("seed", converted_seed)
	$Cloud2.material.set_shader_param("cloud_cover", rand_range(0.28, 0.5))

function set_rotate(r)
	$Cloud.material.set_shader_param("rotation", r)
	$Cloud2.material.set_shader_param("rotation", r)
	
function update_time(t)
	$Cloud.material.set_shader_param("time", t * get_multiplier($Cloud.material) * 0.005)
	$Cloud2.material.set_shader_param("time", t * get_multiplier($Cloud2.material) * 0.005)
	
function set_custom_time(t)
	$Cloud.material.set_shader_param("time", t * get_multiplier($Cloud.material))
	$Cloud2.material.set_shader_param("time", t * get_multiplier($Cloud2.material))


local color_vars1 = {"base_color", "outline_color", "shadow_base_color", "shadow_outline_color"}
local color_vars2 = {"base_color", "outline_color", "shadow_base_color", "shadow_outline_color"}
function get_colors()	
	return (_get_colors_from_vars($Cloud.material, color_vars1) + _get_colors_from_vars($Cloud2.material, color_vars2))

function set_colors(colors)
	_set_colors_from_vars($Cloud.material, color_vars1, colors.slice(0, 3, 1))
	_set_colors_from_vars($Cloud2.material, color_vars2, colors.slice(4, 7, 1))

function randomize_colors()
	local seed_colors = _generate_new_colorscheme(8 + randi()%4, rand_range(0.3, 0.8), 1.0)
	local cols1= {}
	local cols2= {}
	for i in 4:
		local new_col = seed_colors[1+i].darkened(i/6.0).darkened(0.7)
--		new_col = new_col.lightened((1.0 - (i/4.0)) * 0.2)
		cols1.append(new_col)
	
	for i in 4:
		local new_col = seed_colors[1+i+4].darkened(i/4.0)
		new_col = new_col.lightened((1.0 - (i/4.0)) * 0.5)
		cols2.append(new_col)

	set_colors(cols1 + cols2)

