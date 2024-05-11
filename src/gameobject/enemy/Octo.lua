local Enemy = require 'gameobject.enemy.Enemy'
local Octo = Enemy:clone("Octo")

local IMG_ENEMY_OCTO = love.graphics.newImage("assets/gfx/pico8_invaders/Octo.png")

function Octo:init(x, y)
	Enemy.init(self, x, y)
	self.img = IMG_ENEMY_OCTO
	self.speed = 100
	self.bountyModifier = 4

	self.animation = Animation:new(8, {
		love.graphics.newQuad(0 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight()),
		love.graphics.newQuad(1 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight())
	})
	self.animation.callbacks:register("finish", function(anim, enemy)
		local bullet = Bullet_Dot:new(self.x, self.y + 6, math.pi, self.alliance)
		bullet.speed = 220
		GET("Scenemanager"):getActiveScene():insert(bullet)


		local bullet = Bullet_Dot:new(self.x, self.y + 6, math.pi - 0.4, self.alliance)
		bullet.speed = 220
		GET("Scenemanager"):getActiveScene():insert(bullet)


		local bullet = Bullet_Dot:new(self.x, self.y + 6, math.pi + 0.4, self.alliance)
		bullet.speed = 220
		GET("Scenemanager"):getActiveScene():insert(bullet)
	end, self.animation, self)

	self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(8, self.die, self))
	return self
end

function Octo:update(dt)
	self.jobs:update(dt)

	self:drift(dt)
	--self:drift(dt)

	-- self:collisionResolution()
end

return Octo
