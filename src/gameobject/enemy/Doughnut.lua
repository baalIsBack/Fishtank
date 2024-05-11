local Super = require 'gameobject.enemy.Enemy'
local Self = Super:clone("Doughnut")

local IMG = love.graphics.newImage("assets/gfx/retro-shoot-em-up/Doughnut.png")

function Self:init(x, y)
	Super.init(self, x, y)
	self.img = IMG
	self.speed = 75
	self.bountyModifier = 2

	self.animation = Animation:new(8, {
		love.graphics.newQuad(0 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight())
	}):pause()


	self.time = 0

	self.anchorX = x

	self.rotationModifier = 10
	self.rotationalDamping = 0
	self.linearDamping = 100
	self.linearModifier = 350

	self:targetFunction()
	--self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(20, self.die, self))
	self.jobs:insert(cron.every(0.1, self.targetFunction, self))
	return self
end

function Self:update(dt)
	self.time = self.time + dt
	self.jobs:update(dt)
	self:moveToTarget(dt)
end

function Self:draw()
	love.graphics.draw(self.img, self.animation:getQuad(), self.body:getX(), self.body:getY(), -math.pi+math.pi/2-self.body:getAngle(), self.sx, self.sy, self.spritesize / 2,
		self.spritesize / 2)
	self:drawHitbox()
	self:drawTargetHint()
	
	local force = 10
	local angle = self.body:getAngle()
	love.graphics.line(self.body:getX(), self.body:getY(), force * math.cos( angle ), force * -math.sin(angle))
end

function Self:applyBoost()
	applyDirectionalImpulse(self.body, 5)
end

function Self:increase()
	self.time = self.time + 0.01
end

function Self:targetFunction()
	self.target:setX(self.anchorX + 100*math.sin(self.time*4))
	self.target:setY(self.body:getY() + 200)
	self.body:setAngle(ANGLE(self.body:getX(), self.body:getY(), self.target:getX(), self.target:getY()))
end

return Self
