local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/land_masses/planet_under.fp")


  


  


material.transform = {5.228,100.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {10.0,0.0,0.1,3.0,}
material.shader:send("generic", material.generic)


material.lights = {0.39,0.39,0.0,0.0,}
material.shader:send("lights", material.lights)


material.border = {0.4,0.6,0.0,0.0,}
material.shader:send("border", material.border)


material.modify = {0.0,0.0,2.0,0.0,}
material.shader:send("modify", material.modify)


material.color1 = {0.57,0.91,0.75,1.0,}
material.shader:send("color1", material.color1)


material.color2 = {0.31,0.64,0.72,1.0,}
material.shader:send("color2", material.color2)


material.color3 = {0.17,0.21,0.3,1.0,}
material.shader:send("color3", material.color3)

return material