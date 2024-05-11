local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/no_atmosphere/craters.fp")


  


  



material.transform = {5.0,87.419,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {4.517,0.0,0.001,0.0,}
material.shader:send("generic", material.generic)


material.lights = {0.25,0.25,0.0,0.0,}
material.shader:send("lights", material.lights)


material.border = {0.465,0.0,0.0,0.0,}
material.shader:send("border", material.border)


material.color1 = {0.3,0.41,0.52,1.0,}
material.shader:send("color1", material.color1)


material.color2 = {0.23,0.25,0.37,1.0,}
material.shader:send("color2", material.color2)

return material