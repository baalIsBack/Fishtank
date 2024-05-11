local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/land_masses/land_masses.fp")


  


  


material.transform = {4.292,100.0,0.2,0.0,}
material.shader:send("transform", material.transform)


material.lights = {0.39,0.39,0.0,0.0,}
material.shader:send("lights", material.lights)


material.generic = {7.947,0.0,0.2,6.0,}
material.shader:send("generic", material.generic)


material.border = {0.32,0.534,0.0,0.0,}
material.shader:send("border", material.border)


material.extras = {0.0,0.0,0.633,0.0,}
material.shader:send("extras", material.extras)


material.col1 = {0.78,0.83,0.36,1.0,}
material.shader:send("col1", material.col1)


material.col2 = {0.39,0.67,0.25,1.0,}
material.shader:send("col2", material.col2)


material.col3 = {0.18,0.34,0.33,1.0,}
material.shader:send("col3", material.col3)


material.col4 = {0.16,0.21,0.25,1.0,}
material.shader:send("col4", material.col4)

return material