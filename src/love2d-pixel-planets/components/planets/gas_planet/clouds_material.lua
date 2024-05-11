local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/gas_planet/gas_planet.fp")


  


  


material.transform = {9.0,100.0,0.0,1.0,}
material.shader:send("transform", material.transform)


material.modify = {0.538, 1.3, 0.0, 0.0,}
material.shader:send("modify", material.modify)


material.lights = {0.25, 0.25, 0.0, 0.0,}
material.shader:send("lights", material.lights)


material.generic = {5.939, 0.0, 0.47, 5.0,}
material.shader:send("generic", material.generic)


material.border = {0.439, 0.746, 0.0, 0.0,}
material.shader:send("border", material.border)


material.base_color = {0.94, 0.71, 0.25, 1.0,}
material.shader:send("base_color", material.base_color)


material.outline_color = {0.81, 0.46, 0.17, 1.0,}
material.shader:send("outline_color", material.outline_color)


material.shadow_base_color = {0.67, 0.32, 0.19, 1.0,}
material.shader:send("shadow_base_color", material.shadow_base_color)


material.shadow_outline_color = {0.49, 0.22, 0.2, 1.0,}
material.shader:send("shadow_outline_color", material.shadow_outline_color)

return material