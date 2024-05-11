local Super = require 'gameobject.projectile.Projectile'
local Self = Super:clone("Missile")

local IMG = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Projectiles/Player_missile_shots (16 x 16).png")

Self.shape = love.physics.newRectangleShape(4, 4)

function Self:init(parent, x, y, angle)
	Super.init(self, parent, x, y)
	self.img = IMG

	self.body:setAngle(angle)
	self.fixture:setCategory(FIXTURE_CATEGORY("projectile"))

	applyDirectionalImpulse(self.body, 1)
	self.rotationModifier = 2
	self.rotationalDamping = 5
	self.linearDamping = 100
	self.linearModifier = 180

	local dist = 1000
	self.target:setX(self.body:getX()+1000*math.cos(angle))
	self.target:setY(self.body:getY()-1000*math.sin(angle))

  self.spritesize = 16
	self.animation = Animation:new(15, {
		love.graphics.newQuad(0 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight()),
		love.graphics.newQuad(1 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight())
	})

	self.jobs:insert(cron.after(10, self.die, self))
	
	self.jobs:insert(self.animation)
	self.jobs:insert(cron.every(0.1, self.targetFunction, self))


	return self
end

function Self:targetFunction()
	if not self:targetClosestEnemy() then
		self:targetFront()
	end
end

function Self:draw()
	love.graphics.draw(self.img, self.animation:getQuad(), self.body:getX(), self.body:getY(), math.pi/2-self.body:getAngle(), self.sx, self.sy, 8, 8)
	--[[if self.quad then
		love.graphics.draw(self.img, self.quad, self.body:getX(), self.body:getY(), self.body:getAngle(), self.sx, self.sy, 8, 8)
	else
		love.graphics.draw(self.img, self.body:getX(), self.body:getY(), self.body:getAngle(), self.sx, self.sy, self.img:getWidth()/2, self.img:getHeight()/2)
	end]]

	self:drawTargetHint()

	self:drawRotationHint()

	self:drawHitbox()
end

return Self
