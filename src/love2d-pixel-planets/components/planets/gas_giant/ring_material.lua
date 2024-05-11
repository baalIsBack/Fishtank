local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/gas_giant/ring.fp")


  


  


material.transform = {15.0,300.0,0.732,0.0,}
material.shader:send("transform", material.transform)


material.generic = {8.461,0.0,0.2,4.0,}
material.shader:send("generic", material.generic)


material.lights = {-0.1,0.3,0.0,0.0,}
material.shader:send("lights", material.lights)


material.modify = {0.0,0.0,0.0,6.0,}
material.shader:send("modify", material.modify)


material.extras = {0.127,6.0,0.0,0.0,}
material.shader:send("extras", material.extras)





return material