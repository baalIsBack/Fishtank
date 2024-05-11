local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/asteroids/asteroid.fp")


  


  


material.transform = {5.294,100.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {1.567,0.0,0.4,2.0,}
material.shader:send("generic", material.generic)


material.lights = {0.0,0.0,0.0,0.0,}
material.shader:send("lights", material.lights)


material.color1 = {0.64,0.65,0.76,1.0,}
material.shader:send("color1", material.color1)


material.color2 = {0.3,0.41,0.52,1.0,}
material.shader:send("color2", material.color2)


material.color3 = {0.23,0.25,0.37,1.0,}
material.shader:send("color3", material.color3)

return material