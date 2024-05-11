local Enemy = require 'gameobject.enemy.Enemy'
local Alan = Enemy:clone("Alan")

local IMG_ENEMY_ALAN = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Enemies/Alan (16 x 16).png")

function Alan:init(x, y)
	Enemy.init(self, x, y)
	self.img = IMG_ENEMY_ALAN
	self.speed = 100
	self.bountyModifier = 3

	self.bloated = false
	self.bloat_counter = 0
	self.animation = Animation:new(12, {
		love.graphics.newQuad(0 * 16, 0, 16, 16, 6 * 16, 16),
		love.graphics.newQuad(1 * 16, 0, 16, 16, 6 * 16, 16),
		love.graphics.newQuad(2 * 16, 0, 16, 16, 6 * 16, 16),
		love.graphics.newQuad(5 * 16, 0, 16, 16, 6 * 16, 16),
		love.graphics.newQuad(4 * 16, 0, 16, 16, 6 * 16, 16),
		love.graphics.newQuad(3 * 16, 0, 16, 16, 6 * 16, 16),
	}, false):reverse()
	self.animation.callbacks:register("finish", function(anim, enemy)
		if not self.bloated and self.bloat_counter == 1 then
			self.bloated = true
		end
	end, self.animation, self)

	self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(16, self.die, self))
	self.jobs:insert(cron.every(math.random(0.6, 1.3), self.rotateToPlayer, self))


	self.jobs:insert(cron.every(1.2, function(self)
		self.animation:reverse():restart()
		self.bloated = false
		self.bloat_counter = (self.bloat_counter + 1) % 2
	end, self))

	self.callbacks:register("killed", self.bloater)
	return self
end

function Alan:update(dt)
	self.jobs:update(dt)
	--self:drift(dt)

	self:move(dt)
	-- self:collisionResolution()

	if DIST(self.x, self.y, GET("Scenemanager"):getActiveScene().player.x, GET("Scenemanager"):getActiveScene().player.y) < 60 then
		self.animation:play()
	end
end

function Alan:bloater()
	if self.bloated then
		local dist = 16
		for r = 0, 8 - 1, 1 do
			local rot = r * (math.pi / (8 / 2))
			local bullet = Bullet_Dot:new(self.x + math.sin(rot) * dist, self.y - math.cos(rot) * dist, rot,
				self.alliance)
			GET("Scenemanager"):getActiveScene():insert(bullet)
		end
	end
end

return Alan
