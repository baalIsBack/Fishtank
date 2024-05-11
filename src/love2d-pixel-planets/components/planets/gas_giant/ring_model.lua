local mesh = require("QuadMesh")
local material = require("love2d-pixel-planets/components/planets/gas_giant/ring_material")
mesh:setTexture(love.graphics.newImage("love2d-pixel-planets/components/planets/gas_giant/gas_giant_colors.png"))
--mesh:setTexture(love.graphics.newImage("love2d-pixel-planets/components/planets/gas_giant/gas_giant_dark_colors.png"))
material.shader:send("dark_colorscheme", love.graphics.newImage("love2d-pixel-planets/components/planets/gas_giant/gas_giant_dark_colors.png"))




return {mesh, material}