local Enemy = require 'gameobject.enemy.Enemy'
local RedDude = Enemy:clone("RedDude")

local IMG_ENEMY_REDDUDE = love.graphics.newImage("assets/gfx/pico8_invaders/RedDude.png")

function RedDude:init(x, y)
	Enemy.init(self, x, y)
	self.img = IMG_ENEMY_REDDUDE
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

function RedDude:update(dt)
	self.jobs:update(dt)

	self:rotateToPlayer()
	local dir_x, dir_y = math.sin(self.r), -math.cos(self.r)
	local norm = NORM(dir_x, dir_y)
	dir_x, dir_y = dir_x / norm, dir_y / norm

	self.x = self.x + dir_x * self.speed * dt

	--local driftSpeed = GET("Starfield").speed
	--self.y = self.y + driftSpeed * dt
	self:drift(dt)
	--self:drift(dt)

	-- self:collisionResolution()
end

return RedDude
