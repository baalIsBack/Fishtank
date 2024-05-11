local Enemy = require 'gameobject.enemy.Enemy'
local BlueThing = Enemy:clone("BlueThing")

local IMG_ENEMY_BLUETHING = love.graphics.newImage(
	"assets/gfx/pico8_invaders/BlueThing.png")

function BlueThing:init(x, y)
	Enemy.init(self, x, y)
	self.y = WINDOW_HEIGHT - self.y
	self.img = IMG_ENEMY_BLUETHING
	self.speed = 75
	self.bountyModifier = 2

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

function BlueThing:update(dt)
	self.jobs:update(dt)

	self.y = self.y - self.speed * dt
	-- self:drift(dt)

	-- self:collisionResolution()
end

return BlueThing
