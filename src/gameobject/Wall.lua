local Super = require 'gameobject.GameObject'
local Self = Super:clone("Wall")

Self.shape = love.physics.newRectangleShape(love.graphics.getWidth()/4, 16)


function Self:init(x, y)
	Super.init(self, x, y)




	self.w = love.graphics.getWidth()/4
	self.h = 32
	self.body:setMass(100000)

	self.body = love.physics.newBody(GET("World"), x, y, "static")
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)

	return self
end

function Self:update(dt)
	self.jobs:update(dt)
end

function Self:draw()
	love.graphics.push()
	love.graphics.translate(math.floor(self.body:getX()), math.floor(self.body:getY()) )
	--love.graphics.rotate(self.body:getAngle())
	love.graphics.setColor(1, 0, 0, 0.3)
	--love.graphics.polygon("fill", self.shape:getPoints())

	--love.graphics.circle("line", 0, 0, 2, 40)


	love.graphics.setColor(1, 1, 1)
	love.graphics.pop()
end

return Self
