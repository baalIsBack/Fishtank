local Super = require 'gameobject.projectile.Projectile'
local Self = Super:clone("Laser")

local IMG = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Projectiles/Player_missile_shots (16 x 16).png")


function Self:init(parent, x, y)
	Super.init(self, x, y)
	self.r = 0
	self.speed = 98
	self.img = IMG
  self.w = 4
  self.h = 4

  self.spritesize = 16
	self.animation = Animation:new(15, {
		love.graphics.newQuad(0 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight()),
		love.graphics.newQuad(1 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight())
	})

	return self
end

function Self:update(dt)
	local player = GET("Scenemanager"):getActiveScene().player
	self.x = player.x
	self.y = 0
	self.h = self.y

	self.jobs:update(dt)
end

function Self:draw()
	love.graphics.draw(self.img, self.animation:getQuad(), self.x, self.y, self.r, self.sx, self.sy, 8, 8)
	--[[if self.quad then
		love.graphics.draw(self.img, self.quad, self.x, self.y, self.r, self.sx, self.sy, 8, 8)
	else
		love.graphics.draw(self.img, self.x, self.y, self.r, self.sx, self.sy, self.img:getWidth()/2, self.img:getHeight()/2)
	end]]
	self:drawHitbox()
end

return Self
