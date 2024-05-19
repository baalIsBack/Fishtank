local Super = require 'gameobject.GameObject'
local Self = Super:clone("StartBubble")

Self.shape = love.physics.newCircleShape(3)
Self.sound = love.audio.newSource("assets/sfx/bubblepop.wav", "static")
Self.sound:setVolume(0.2)

Self.img = love.graphics.newImage("assets/gfx/bubble1.png")
function Self:init(x, y)
	Super.init(self, x, y)


	
	self.body:setMass(100)

	self.body:applyLinearImpulse(-GET("driftspeed") * 100, 0)
	local accuracy = 1000
	local anglestrength = 0.3
	self.body:setAngle(math.pi)
	self.body:setAngularDamping(1000)
	--self.body:setFixedRotation(true)
	self.body:setLinearDamping(0.6)
	self.callbacks:register("collision", self.onCollision)

	self.offset = math.random(0, 1000)

	self.direction = "left"
	self.counter = math.random(0, 100)

	return self
end

function Self:onCollision(gameObject)
	if gameObject.killsFish then
		self:die()
		SET("isPlaying", true)
		self.sound:play()
	end
end



function Self:update(dt)
	self.jobs:update(dt)
	self.counter = self.counter + dt

	if GET("isPlaying") then
		self:die()
	end


end

function Self:draw()
	--love.graphics.draw(self.img, math.floor(self.body:getX()), math.floor(self.body:getY()), math.pi-self.body:getAngle(), 1, 1, 4, 4)
	--love.graphics.setColor(16/255, 115/255, 235/255, 1)
	local x, y = (self.body:getX()), (self.body:getY()) + math.sin(self.counter)*3
	--love.graphics.circle("line", x, y, 10, 44)
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("GO!", ROUND(x-6), ROUND(y-12), 0, 1/7, 1/7)

	love.graphics.draw(self.img, x-4, y-4)
end

return Self
