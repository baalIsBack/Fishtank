local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/builtins/materials/gui.fp")

material.view_proj = {0.0,0.0,0.0,0.0,}
material.shader:send("view_proj", material.view_proj)

return material