local Loot = require 'gameobject.loot.Loot'
local Metal = Loot:clone("Metal")

IMG_METAL_1 = love.graphics.newImage("assets/gfx/Alien Breaker/Enemies and Objects/metal_piece_1.png")
IMG_METAL_2 = love.graphics.newImage("assets/gfx/Alien Breaker/Enemies and Objects/metal_piece_2.png")

function Metal:init(x, y)
  Loot.init(self, x, y)

  self.quad = love.graphics.newQuad(6*16, 0*16, 16, 16, self.img:getWidth(), self.img:getHeight())

  local r = math.random(1,2)
  if r == 1 then
    self:setImage(IMG_METAL_1)
  else
    self:setImage(IMG_METAL_2)
  end

  
  
  return self
end

return Metal
