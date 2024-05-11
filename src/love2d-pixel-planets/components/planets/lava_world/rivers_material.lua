local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/lava_world/rivers.fp")


  


  


material.transform = {10.0,100.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {2.527,0.0,0.2,4.0,}
material.shader:send("generic", material.generic)


material.lights = {0.3,0.3,0.0,0.0,}
material.shader:send("lights", material.lights)


material.border = {0.019,0.036,0.0,0.0,}
material.shader:send("border", material.border)


material.extras = {0.0,0.0,0.579,0.0,}
material.shader:send("extras", material.extras)


material.color1 = {1.0,0.54,0.2,1.0,}
material.shader:send("color1", material.color1)


material.color2 = {0.9,0.27,0.22,1.0,}
material.shader:send("color2", material.color2)


material.color3 = {0.68,0.18,0.27,1.0,}
material.shader:send("color3", material.color3)

return material