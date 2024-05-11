local Enemy = require 'gameobject.enemy.Enemy'
local Robo = Enemy:clone("Robo")

local IMG_ENEMY_ROBO = love.graphics.newImage(
	"assets/gfx/pico8_invaders/Robo.png")

function Robo:init(x, y)
	Enemy.init(self, x, y)
	self.img = IMG_ENEMY_ROBO
	self.speed = 100
	self.bountyModifier = 2

	self.animation = Animation:new(8, {
		love.graphics.newQuad(0 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight()),
		love.graphics.newQuad(1 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight())
	})

	self.callbacks:register("killed", function(self)
		local explosion = Explosion:new(self:getX(), self:getY(), 6)
		GET("Scenemanager"):getActiveScene():insert(explosion)
		explosion.alliance = "neutral" -- self.alliance
	end, self)

	self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(8, self.die, self))
	return self
end

function Robo:update(dt)
	self.jobs:update(dt)

	self:drift(dt)
	-- self:drift(dt)

	-- self:collisionResolution()
end

return Robo
