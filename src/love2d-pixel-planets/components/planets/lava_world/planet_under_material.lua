local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/no_atmosphere/no_atmosphere.fp")


  


  



material.transform = {10.0,100.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {1.551,0.0,0.2,3.0,}
material.shader:send("generic", material.generic)


material.lights = {0.3,0.3,0.0,0.0,}
material.shader:send("lights", material.lights)


material.border = {0.4,0.6,0.0,0.0,}
material.shader:send("border", material.border)


material.modify = {0.0,0.0,2.0,0.0,}
material.shader:send("modify", material.modify)


material.color1 = {0.56,0.3,0.34,1.0,}
material.shader:send("color1", material.color1)


material.color2 = {0.32,0.2,0.25,1.0,}
material.shader:send("color2", material.color2)


material.color3 = {0.24,0.16,0.21,1.0,}
material.shader:send("color3", material.color3)

return material