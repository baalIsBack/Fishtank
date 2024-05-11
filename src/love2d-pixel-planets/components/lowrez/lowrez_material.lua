local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/lowrez/lowrez.fp")


  


  


  


material.tint = {1.0,1.0,1.0,1.0,}
material.shader:send("tint", material.tint)



return material