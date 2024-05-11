local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/ice_world/lakes.fp")


  


  


material.transform = {10.0,100.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {1.14,0.0,0.2,3.0,}
material.shader:send("generic", material.generic)


material.border = {0.024,0.047,0.0,0.0,}
material.shader:send("border", material.border)


material.extras = {0.0,0.0,0.55,0.0,}
material.shader:send("extras", material.extras)


material.lights = {0.3,0.3,0.0,0.0,}
material.shader:send("lights", material.lights)


material.color1 = {0.31,0.64,0.72,1.0,}
material.shader:send("color1", material.color1)


material.color2 = {0.3,0.41,0.52,1.0,}
material.shader:send("color2", material.color2)


material.color3 = {0.23,0.25,0.37,1.0,}
material.shader:send("color3", material.color3)

return material