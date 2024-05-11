local Super = require 'gameobject.enemy.Enemy'
local Self = Super:clone("Circle")

local IMG = love.graphics.newImage("assets/gfx/retro-shoot-em-up/Circle.png")

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

	self:transitionState("down")

	self.body:applyLinearImpulse(0, 10)


	self.rotationModifier = 500
	self.rotationalDamping = 5
	self.linearDamping = 100
	self.linearModifier = 150
	self.distanceMovementShutoff = 8
	self.visualRotation = false
	self.body:setMass(200)


	self.target:setX(self.body:getX())
	self.target:setY(WINDOW_WIDTH/2+100)


	--self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(8, self.die, self))
	return self
end

function Self:statemachine()
	local player = GET("Scenemanager"):getActiveScene().player
	local x_diff = player.body:getX() - self.body:getX()

	if self.state == "down" and self.body:getY() > player.body:getY() then
		self:transitionState("target")
	elseif self.state == "target" and math.abs(x_diff) < 5 then
		self:transitionState("up")
	elseif self.state == "up" then
		--terminal state
	end
end

function Self:transitionState(newState)
	local player = GET("Scenemanager"):getActiveScene().player
	local x_diff = player.body:getX() - self.body:getX()

	self.state = newState
	if 			self.state == "down" then
		self.body:setLinearVelocity(0, 100)
	elseif 	self.state == "target" then
		local x_diff = player.body:getX() - self.body:getX()
		self.body:setLinearVelocity(120 * x_diff / math.abs(x_diff), -100 )
	elseif 	self.state == "up" then
		self.body:setLinearVelocity(0, -200)
	end
end

function Self:update(dt)

	self.jobs:update(dt)



	self:statemachine()


	-- self:collisionResolution()
end

return Self
