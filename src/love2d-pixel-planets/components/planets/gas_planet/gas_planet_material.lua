local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/gas_planet/gas_planet.fp")


  


  


material.transform = {9.0,100.0,0.0,1.0,}
material.shader:send("transform", material.transform)


material.modify = {0.0,1.3,0.0,0.0,}
material.shader:send("modify", material.modify)


material.lights = {0.25, 0.25, 0.0, 0.0,}
material.shader:send("lights", material.lights)


material.generic = {5.939,0.0,0.7,5.0,}
material.shader:send("generic", material.generic)


material.border = {0.692,0.666,0.0,0.0,}
material.shader:send("border", material.border)


material.base_color = {0.23,0.13,0.15,1.0,}
material.shader:send("base_color", material.base_color)


material.outline_color = {0.23,0.13,0.15,1.0,}
material.shader:send("outline_color", material.outline_color)


material.shadow_base_color = {0.13,0.09,0.11,1.0,}
material.shader:send("shadow_base_color", material.shadow_base_color)


material.shadow_outline_color = {0.13,0.09,0.11,1.0,}
material.shader:send("shadow_outline_color", material.shadow_outline_color)

return material