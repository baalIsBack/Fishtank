local Super = require 'gameobject.GameObject'
local Self = Super:clone("Enemy")

Self.shape = love.physics.newRectangleShape(16, 16)

function Self:init(x, y)
	Super.init(self, x, y)
	self.spritesize = 16

	self.body:setAngle( (3/2) * math.pi)

	self.fixture:setCategory(FIXTURE_CATEGORY("enemy"))
	--self.fixture:setMask(FIXTURE_CATEGORY("enemy"))

	self.bountyModifier = 1

	self.callbacks:register("killed", self.spawnExplosion)
	self.callbacks:register("killed", self.rewardBounty)
	self.callbacks:register("collision", self.dieOnNonPlayerContact)
	self.jobs:insert(cron.every(0.3, self.dieOnOOB, self, true))

	self.visualRotation = false

	return self
end

function Self:update(dt)
	self.jobs:update(dt)
	self:moveToTarget(dt)
end

function Self:draw()
	local angle = 0
	if self.visualRotation then
		angle = -math.pi+math.pi/2-self.body:getAngle()
	else
		angle = 0
	end
	love.graphics.draw(self.img, self.animation:getQuad(), self.body:getX(), self.body:getY(), angle, self.sx, self.sy, self.spritesize / 2,
		self.spritesize / 2)
	self:drawHitbox()
	self:drawTargetHint()
	self:drawRotationHint()
end

function Self:spawnExplosion()
	local explosion = Explosion:new(self.body:getX(), self.body:getY(), true)
	GET("Scenemanager"):getActiveScene():insert(explosion)
	return explosion
end

function Self:dieOnNonPlayerContact(gameObject)
	if gameObject.isProjectile then
		self:die(true)
	end
end

function Self:rewardBounty()
	local activeScene = GET("Scenemanager"):getActiveScene()

	local combo = GET("Hyperdrift").combo + self.bountyModifier / 10
	GET("Hyperdrift").combo = combo

	local stats = GET("Statsheet")
	local luckyThreshold = 1 - ((1 - (0.005)) ^ (1 + (stats.drop_modifier * self.bountyModifier * combo)))

	local precision = 1000000
	local rand = math.random(0, precision) / precision
	if rand < luckyThreshold then
		local Metal = require 'gameobject.loot.Metal'
		local scene_game = GET("Scenemanager"):get(Scene_Game:type())
		local x, y = self.x, self.y
		--scene_game:insert(Metal:new(x, y))
	end
end

function Self:pastFairnessLine()
	return self.body:getY() > WINDOW_HEIGHT * (2 / 3)
end

return Self
