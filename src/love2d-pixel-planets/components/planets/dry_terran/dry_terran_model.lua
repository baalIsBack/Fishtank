local mesh = require("QuadMesh")
local material = require("love2d-pixel-planets/components/planets/dry_terran/dry_terran_material")
mesh:setTexture(love.graphics.newImage("love2d-pixel-planets/components/planets/dry_terran/dry_terran.png"))




return {mesh, material}