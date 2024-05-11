local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/star/star_blobs.fp")


  


  


material.transform = {4.93,200.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {3.078,0.0,0.05,4.0,}
material.shader:send("generic", material.generic)


material.circles = {2.0,1.0,0.0,0.0,}
material.shader:send("circles", material.circles)


material.color = {1.0,1.0,0.89,1.0,}
material.shader:send("color", material.color)

return material