local mesh = require("QuadMesh")
local material = require("love2d-pixel-planets/components/planets/star/star_flares_material")
mesh:setTexture(love.graphics.newImage("love2d-pixel-planets/components/planets/star/star_flares.png"))




return {mesh, material}