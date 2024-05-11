local Enemy = require 'gameobject.enemy.Enemy'
local Parasite = Enemy:clone("Parasite")

local IMG_ENEMY_PARASITE = love.graphics.newImage("assets/gfx/pico8_invaders/Parasite.png")

function Parasite:init(x, y)
	Enemy.init(self, x, y)
	self.img = IMG_ENEMY_PARASITE
	self.speed = 250
	self.bountyModifier = 3

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
	self:rotateToPlayer()

	return self
end

function Parasite:draw()
	love.graphics.draw(self.img, self.animation:getQuad(), self.x, self.y, self.r + math.pi, self.sx, self.sy,
		self.spritesize / 2, self.spritesize / 2)
	self:drawHitbox()
end

function Parasite:update(dt)
	self.jobs:update(dt)

	self:move(dt)
	--self:drift(dt)

	-- self:collisionResolution()
end

return Parasite
