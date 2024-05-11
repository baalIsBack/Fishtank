local Prototype = require 'lua-additions.Prototype'
local Boosters = Prototype:clone("Boosters")

local IMG_BOOSTERS_NEUTRAL = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Player ship/Boosters (16 x 16).png")
local IMG_BOOSTERS_LEFT = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Player ship/Boosters_left (16 x 16).png")
local IMG_BOOSTERS_RIGHT = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Player ship/Boosters_right (16 x 16).png")



function Boosters:init(player)
  local Animation = require 'lua-additions.Animation'
  
  self.player = player
  self.dir = 0

  self.animation = Animation:new(10, {
    love.graphics.newQuad(0, 0, 16, 16, 32, 16),
    love.graphics.newQuad(16, 0, 16, 16, 32, 16),
  })
  return self
end

function Boosters:update(dt)
  self.animation:update(dt)
  self.dir, _ = calcInput()
end

function Boosters:draw()
  love.graphics.push()

  love.graphics.translate(self.player.body:getX(), self.player.body:getY())
  love.graphics.rotate(math.pi-self.player.body:getAngle())
  if self.dir < 0 then
    love.graphics.draw(IMG_BOOSTERS_LEFT, self.animation:getQuad(), 0, 0,
      -math.pi/2, self.player.sx, self.player.sy, 8, -7)
  elseif self.dir > 0 then
    love.graphics.draw(IMG_BOOSTERS_RIGHT, self.animation:getQuad(), 0, 0,
      -math.pi/2, self.player.sx, self.player.sy, 8, -7)
  else
    love.graphics.draw(IMG_BOOSTERS_NEUTRAL, self.animation:getQuad(), 0, 0,
      -math.pi/2, self.player.sx, self.player.sy, 8, -7)
  end
  love.graphics.pop()
end

return Boosters
