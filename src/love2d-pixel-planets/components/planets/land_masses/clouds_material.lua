local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/land_masses/clouds.fp")


  


  


material.transform = {7.745,100.0,0.0,2.0,}
material.shader:send("transform", material.transform)


material.generic = {5.939,0.0,0.47,2.0,}
material.shader:send("generic", material.generic)


material.border = {0.52,0.62,0.0,0.0,}
material.shader:send("border", material.border)


material.modify = {0.415,1.3,0.0,0.0,}
material.shader:send("modify", material.modify)


material.lights = {0.39,0.39,0.0,0.0,}
material.shader:send("lights", material.lights)


material.base_color = {0.87,0.88,0.91,1.0,}
material.shader:send("base_color", material.base_color)


material.outline_color = {0.64,0.65,0.76,1.0,}
material.shader:send("outline_color", material.outline_color)


material.shadow_base_color = {0.41,0.44,0.6,1.0,}
material.shader:send("shadow_base_color", material.shadow_base_color)


material.shadow_outline_color = {0.25,0.29,0.45,1.0,}
material.shader:send("shadow_outline_color", material.shadow_outline_color)

return material