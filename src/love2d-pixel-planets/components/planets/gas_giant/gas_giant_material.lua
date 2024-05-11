local material = {}


material.shader = love.graphics.newShader("love2d-pixel-planets/components/planets/gas_giant/gas_giant.fp")

--[[
  


  
]]

material.transform = {10.961,100.0,0.0,0.0,}
material.shader:send("transform", material.transform)


material.generic = {6.314,0.0,0.05,3.0,}
material.shader:send("generic", material.generic)


material.border = {0.0,0.0,0.892,0.0,}
material.shader:send("border", material.border)


material.lights = {-0.1,0.3,0.0,0.0,}
material.shader:send("lights", material.lights)





return material