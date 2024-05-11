local Super = require 'gameobject.GameObject'
local Self = Super:clone("Trash")

Self.shape = love.physics.newCircleShape(3)

Self.imgs = {
	love.graphics.newImage("assets/gfx/tin_cant.png"),
	love.graphics.newImage("assets/gfx/fishbone.png"),
	love.graphics.newImage("assets/gfx/trashbag1.png"),
	love.graphics.newImage("assets/gfx/trashbag2.png"),
	love.graphics.newImage("assets/gfx/fishbone2.png"),
}

function Self:init(x, y)
	Super.init(self, x, y)

	self.speed = 40
	local r = math.random(1, #self.imgs)
	self.img = self.imgs[r]

	self.body:setMass(100)

	self.body:applyLinearImpulse(-GET("driftspeed") *100, 0)
	local accuracy = 1000
	self.body:setAngle(math.random(0, 2*math.pi*accuracy)/accuracy)
	self.body:setAngularDamping(1000)
	--self.body:setFixedRotation(true)
	self.killsPlayer = true

	return self
end


function Self:update(dt)
	self.jobs:update(dt)
	self:drift(dt)
end

function Self:draw()
	love.graphics.draw(self.img, math.floor(self.body:getX()), math.floor(self.body:getY()), self.body:getAngle(), 1, 1, 4, 4)
	love.graphics.setColor(1, 0, 0)
	--love.graphics.circle("line", (self.body:getX()), (self.body:getY()), 2, 44)
	love.graphics.setColor(1, 1, 1)
end

return Self
