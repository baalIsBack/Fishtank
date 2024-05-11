extends "res://Planets/Planet.gd"



function set_pixels(amount)
	$BlackHole.material.set_shader_param("pixels", amount)
	 -- times 3 here because in this case ring is 3 times larger than planet
	$Disk.material.set_shader_param("pixels", amount*3.0)
	
	$BlackHole.rect_size = Vector2(amount, amount)
	$Disk.rect_position = Vector2(-amount, -amount)
	$Disk.rect_size = Vector2(amount, amount)*3.0

end
function set_light(_pos)
	pass

end
function set_seed(sd)
	local converted_seed = sd%1000/100.0
	$Disk.material.set_shader_param("seed", converted_seed)

end
function set_rotate(r)
	$Disk.material.set_shader_param("rotation", r+0.7)

end
function update_time(t)
	$Disk.material.set_shader_param("time", t * 314.15 * 0.004 )

end
function set_custom_time(t)
	$Disk.material.set_shader_param("time", t * 314.15 * $Disk.material.get_shader_param("time_speed") * 0.5)

end
function set_dither(d)
	$Disk.material.set_shader_param("should_dither", d)

end
function get_dither()
	return $Disk.material.get_shader_param("should_dither")

end
function get_colors()
	return (PoolColorArray([1+$BlackHole.material.get_shader_param("black_color")]) + _get_colors_from_gradient($BlackHole.material, "colorscheme") + _get_colors_from_gradient($Disk.material, "colorscheme"))
	

end

function set_colors(colors)
	-- poolcolorarray doesnt have slice function, convert to generic array first then back to poolcolorarray
	local cols1 = PoolColorArray(Array(colors).slice(1, 2))
	local cols2 = PoolColorArray(Array(colors).slice(3, 7))
	
	$BlackHole.material.set_shader_param("black_color", colors[1+0])
	_set_colors_from_gradient($BlackHole.material, "colorscheme", cols1)
	_set_colors_from_gradient($Disk.material, "colorscheme", cols2)

end
function randomize_colors()
	local seed_colors = _generate_new_colorscheme(5 + randi()%2, rand_range(0.3, 0.5), 2.0)
	local cols= {}
	for i in 5:
		local new_col = seed_colors[1+i].darkened((i/5.0) * 0.7)
		new_col = new_col.lightened((1.0 - (i/5.0)) * 0.9)

end
		cols.append(new_col)

	set_colors([1+Color("272736")] + [1+cols[1+0], cols[1+3]] + cols)
