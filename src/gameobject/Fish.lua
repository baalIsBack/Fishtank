local Super = require 'gameobject.GameObject'
local Self = Super:clone("Fish")

Self.shape = love.physics.newCircleShape(3)

Self.imgs = {
	love.graphics.newImage("assets/gfx/fish_red.png"),
	love.graphics.newImage("assets/gfx/fish_yellow.png"),
	love.graphics.newImage("assets/gfx/fish_pink.png"),
	love.graphics.newImage("assets/gfx/nemo.png"),
	--love.graphics.newImage("assets/gfx/prettyfish_blue.png"),
	love.graphics.newImage("assets/gfx/prettyfish_red.png"),
	--love.graphics.newImage("assets/gfx/prettyfish_lilac.png"),
	love.graphics.newImage("assets/gfx/rainbowfish.png"),
}

function Self:init(x, y)
	Super.init(self, x, y)

	self.speed = 40
	local r = math.random(1, #self.imgs)
	self.img = self.imgs[r]

	self.body:setMass(100)
	self.sound = love.audio.newSource("assets/sfx/collect.wav", "static")
	self.sound:setVolume(0.1)

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

	return self
end

function Self:onCollision(gameObject)
	if gameObject.killsFish then
		self:die()
		local trashmod = GET("trashmod")
		trashmod = math.max(0, trashmod-0.01)
		SET("trashmod", trashmod)
		TRASH_COUNTER = TRASH_COUNTER + GET("driftspeed")*1+(1-trashmod)
		
		SET("points", GET("points")+100)
		GET("Highscore"):set(GET("points"))
		self.sound:play()
	end
end



function Self:update(dt)
	self.jobs:update(dt)
	self:drift(dt)
	self.body:setAngle(math.pi+math.cos(self.offset+(timer*4)))
	applyDirectionalForce(self.body, 2500)
	if self.body:getX() < -10 then
		self:die()
	end
end

function Self:draw()
	if self.direction == "right" then
		love.graphics.draw(self.img, math.floor(self.body:getX()), math.floor(self.body:getY()), math.pi-self.body:getAngle(), 1, 1, 4, 4)
	else
		love.graphics.draw(self.img, math.floor(self.body:getX()), math.floor(self.body:getY()), math.pi-self.body:getAngle(), -1, 1, 4, 4)
	end
	love.graphics.setColor(1, 0, 0)
	--love.graphics.circle("line", (self.body:getX()), (self.body:getY()), 2, 44)
	love.graphics.setColor(1, 1, 1)
end

return Self
