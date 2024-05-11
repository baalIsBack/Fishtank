local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/dry_terran/dry_terran.fp")


  


  


material.transform = {8.0,100.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {1.175,0.0,0.1,3.0,}
material.shader:send("generic", material.generic)


material.lights = {0.4,0.3,0.362,0.525,}
material.shader:send("lights", material.lights)



return material