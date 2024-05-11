local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/background/background.fp")


  


  


material.time = {0.0,0.0,0.0,0.0,}
material.shader:send("time", material.time)

return material