local Enemy = require 'gameobject.enemy.Enemy'
local BonBon = Enemy:clone("BonBon")

local IMG_ENEMY_BONBON = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Enemies/Bon_Bon (16 x 16).png")

function BonBon:init(x, y)
	Enemy.init(self, x, y)
	self.img = IMG_ENEMY_BONBON
	self.speed = 65
	self.bountyModifier = 3

	self.frozen = false

	self.animation = Animation:new(16, {
		love.graphics.newQuad(0 * 16, 0, 16, 16, 4 * 16, 16),
		love.graphics.newQuad(1 * 16, 0, 16, 16, 4 * 16, 16),
		love.graphics.newQuad(2 * 16, 0, 16, 16, 4 * 16, 16),
		love.graphics.newQuad(3 * 16, 0, 16, 16, 4 * 16, 16),
	}, false):pause()
	self.animation.callbacks:register("finish", function(anim, enemy)
		self.frozen = false
		anim:stop()
		if not self:pastFairnessLine() then
			self:rotateToPlayer()
			local dist = 16
			local diag = math.random(0, 1) * math.pi / 4
			for r = 0, 4 - 1, 1 do
				local rot = r * (math.pi / (4 / 2)) + diag
				local bullet = Bullet_Dot:new(self.x + math.sin(rot) * dist, self.y - math.cos(rot) * dist, rot,
					self.alliance)
				GET("Scenemanager"):getActiveScene():insert(bullet)
			end
		end
	end, self.animation, self)

	self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(8, self.die, self))
	--self.jobs:insert(cron.after(0.1, self.rotateToPlayer, self))
	--self.jobs:insert(cron.every(math.random(10, 130)/100, self.rotateToPlayer, self))

	self.jobs:insert(cron.every(math.random(100, 200) / 100, self.blast, self))

	--self.callbacks:register("death", self.remainForDeathAnimation)
	return self
end

function BonBon:update(dt)
	self.jobs:update(dt)

	if not self.frozen then
		local dir_x, dir_y = math.sin(self.r), -math.cos(self.r)
		local norm = NORM(dir_x, dir_y)
		dir_x, dir_y = dir_x / norm, dir_y / norm

		self.x = self.x + dir_x * self.speed * dt
		self.y = self.y + math.abs(dir_y) * self.speed * dt
	end
	--self:drift(dt)

	-- self:collisionResolution()
end

function BonBon:rotateToPlayer()
	self.r = math.atan2(GET("Scenemanager"):getActiveScene().player.y - self.y,
		GET("Scenemanager"):getActiveScene().player.x - self.x) + math.pi / 2
end

function BonBon:blast()
	if not self:pastFairnessLine() then
		self.animation:play()
		self.frozen = true
	end
end

return BonBon
