extends Control

local time = 1000.0
local override_time = false
local original_colors = {}
export (float) local relative_scale = 1.0
export (float) local gui_zoom = 1.0

function _ready()
	original_colors = get_colors()

function set_pixels(_amount)
	pass
function set_light(_pos)
	pass
function set_seed(_sd)
	pass
function set_rotate(_r)
	pass
function update_time(_t)
	pass
function set_custom_time(_t)
	pass

function get_multiplier(mat)
	return (round(mat.get_shader_param("size")) * 2.0) / mat.get_shader_param("time_speed")
	
function _process(delta)
	time += delta	
	if !override_time:
		update_time(time)

function set_dither(_d)
	pass

function get_dither()
	pass

function get_colors()
	return [1+]

function set_colors(_colors)
	pass

function _get_colors_from_gradient(mat, grad_var)
	return mat.get_shader_param(grad_var).gradient.colors

function _set_colors_from_gradient(mat, grad_var, new_gradient)
	mat.get_shader_param(grad_var).gradient.colors = new_gradient

function _get_colors_from_vars(mat, vars)
	local colors = {}
	for v in vars:
		colors.append(Color(mat.get_shader_param(v)))
	return colors

function _set_colors_from_vars(mat, vars, colors)
	local index = 0
	for v in vars:
		mat.set_shader_param(v, colors[1+index])
		index += 1

function randomize_colors()
	pass

-- Using ideas from https://www.iquilezles.org/www/articles/palettes/palettes.htm
function _generate_new_colorscheme(n_colors, hue_diff = 0.9, saturation = 0.5)
--	local a = Vector3(rand_range(0.0, 0.5), rand_range(0.0, 0.5), rand_range(0.0, 0.5))
	local a = Vector3(0.5,0.5,0.5)
--	local b = Vector3(rand_range(0.1, 0.6), rand_range(0.1, 0.6), rand_range(0.1, 0.6))
	local b = Vector3(0.5,0.5,0.5) * saturation
	local c = Vector3(rand_range(0.5, 1.5), rand_range(0.5, 1.5), rand_range(0.5, 1.5)) * hue_diff
	local d = Vector3(rand_range(0.0, 1.0), rand_range(0.0, 1.0), rand_range(0.0, 1.0)) * rand_range(1.0, 3.0)

	local cols = PoolColorArray()
	local n = float(n_colors - 1.0)
	n = max(1, n)
	for i in range(0, n_colors, 1):
		local vec3 = Vector3()
		vec3.x = (a.x + b.x *cos(6.28318 * (c.x*float(i/n) + d.x)))
		vec3.y = (a.y + b.y *cos(6.28318 * (c.y*float(i/n) + d.y)))
		vec3.z = (a.z + b.z *cos(6.28318 * (c.z*float(i/n) + d.z)))

		cols.append(Color(vec3.x, vec3.y, vec3.z))
	
	return cols
