local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/star/star_flares.fp")


  


  


material.transform = {1.6,200.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {3.078,0.0,0.05,4.0,}
material.shader:send("generic", material.generic)


material.modify = {0.0,0.0,0.0,1.0,}
material.shader:send("modify", material.modify)


material.circles = {2.0,1.0,0.3,0.0,}
material.shader:send("circles", material.circles)



return material