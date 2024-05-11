local mesh = require("QuadMesh")
local material = require("love2d-pixel-planets/components/planets/star/star_material")
mesh:setTexture(love.graphics.newImage("love2d-pixel-planets/components/planets/star/star.png"))




return {mesh, material}