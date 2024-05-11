local Enemy = require 'gameobject.enemy.Enemy'
local Lips = Enemy:clone("Lips")

local IMG_ENEMY_LIPS = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Enemies/Lips (16 x 16).png")

function Lips:init(x, y)
	Enemy.init(self, x, y)
	self.img = IMG_ENEMY_LIPS
	self.speed = 100
	self.bountyModifier = 2


	self.animation = Animation:new(12, {
		love.graphics.newQuad(0 * 16, 0, 16, 16, IMG_ENEMY_LIPS:getWidth(), IMG_ENEMY_LIPS:getHeight()),
		love.graphics.newQuad(1 * 16, 0, 16, 16, IMG_ENEMY_LIPS:getWidth(), IMG_ENEMY_LIPS:getHeight()),
		love.graphics.newQuad(2 * 16, 0, 16, 16, IMG_ENEMY_LIPS:getWidth(), IMG_ENEMY_LIPS:getHeight()),
		love.graphics.newQuad(3 * 16, 0, 16, 16, IMG_ENEMY_LIPS:getWidth(), IMG_ENEMY_LIPS:getHeight()),
		love.graphics.newQuad(4 * 16, 0, 16, 16, IMG_ENEMY_LIPS:getWidth(), IMG_ENEMY_LIPS:getHeight()),
	}, false):pause()
	self.animation.callbacks:register("finish", function(anim, enemy)
		self:rotateToPlayer(true)
		if not self:pastFairnessLine() then
			local bullet = Bullet_Dot:new(self.x, self.y, self.r, self.alliance)
			GET("Scenemanager"):getActiveScene():insert(bullet)
		end
		anim:stop()
	end, self.animation, self)

	self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(8, self.die, self))
	--self.jobs:insert(cron.every(math.random(10, 130)/100, self.rotateToPlayer, self))

	self.jobs:insert(cron.every((math.random(10, 50) + math.random(10, 50)) / 100, self.animation.play, self.animation))
	--self.jobs:insert(cron.every(math.random(75, 200) / 100, self.animation.play, self.animation))

	--self.callbacks:register("death", self.remainForDeathAnimation)
	return self
end

function Lips:draw()
	love.graphics.draw(self.img, self.animation:getQuad(), self.x, self.y, 0, self.sx, self.sy, self.spritesize / 2,
		self.spritesize / 2)
	local r = self.r
	local x, y = math.cos(r), -math.sin(r)

	self:drawHitbox()
end

function Lips:update(dt)
	self.jobs:update(dt)

	self:drift(dt)

	-- self:collisionResolution()
end

return Lips
