local Enemy = require 'gameobject.enemy.Enemy'
local GreenCount = Enemy:clone("GreenCount")

local IMG_ENEMY_GREENCUNT = love.graphics.newImage("assets/gfx/pico8_invaders/GreenCount.png")

function GreenCount:init(x, y)
	Enemy.init(self, x, y)
	self.img = IMG_ENEMY_GREENCUNT
	self.speed = 100
	self.bountyModifier = 1

	self.animation = Animation:new(8, {
		love.graphics.newQuad(0 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight()),
		love.graphics.newQuad(1 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight())
	})

	self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(8, self.die, self))
	return self
end

function GreenCount:update(dt)
	self.jobs:update(dt)

	self:drift(dt)
	--self:drift(dt)

	-- self:collisionResolution()
end

return GreenCount
