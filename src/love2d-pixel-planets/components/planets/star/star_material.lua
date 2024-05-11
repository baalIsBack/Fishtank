local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/star/star.fp")


  


  


material.transform = {4.463,100.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {4.837,51.877,0.05,0.0,}
material.shader:send("generic", material.generic)


material.extras = {0.0,0.0,0.0,1.0,}
material.shader:send("extras", material.extras)



return material