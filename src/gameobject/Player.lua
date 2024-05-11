local Super = require 'gameobject.GameObject'
local Self = Super:clone("Player")

local QUAD_SHIP_NEUTRAL = love.graphics.newQuad(1 * 16, 0 * 16, 16, 16, 48, 16)
local QUAD_SHIP_LEFT = love.graphics.newQuad(0 * 16, 0 * 16, 16, 16, 48, 16)
local QUAD_SHIP_RIGHT = love.graphics.newQuad(2 * 16, 0 * 16, 16, 16, 48, 16)

Self.kutter_img = love.graphics.newImage("assets/gfx/kutter.png")
Self.netz_img = love.graphics.newImage("assets/gfx/netz.png")
Self.shape = love.physics.newRectangleShape(2, 11)--love.physics.newPolygonShape( 2, -4, x2, y2, x3, y3, ... )



function Self:init(x, y)
	Super.init(self, x, y)

	SET("player", self)

	self.speed = 60
	self.body:setAngle(math.pi)

	self.shipbody = love.physics.newBody(GET("World"), x, 11, "dynamic")

	self.callbacks:register("collision", self.onCollision)

	self.rope_length = 80
	self.rope = love.physics.newRopeJoint( self.body, self.shipbody, self.body:getX(), self.body:getY(), self.shipbody:getX(), self.shipbody:getY(), self.rope_length, false )

	self.killsFish = true

	self.body:setLinearDamping(10)

	self.ropespeed = 20


	return self
end

function Self:onCollision(gameObject)
	if gameObject.killsPlayer then
		self:die()
	end
end


function Self:update(dt)
	self.jobs:update(dt)
	local dx, dy = 0, 0
	if love.keyboard.isDown("w") then
		self.rope_length = self.rope_length - self.ropespeed*dt
	end
	if love.keyboard.isDown("a") then
		dx = dx - 1
	end
	if love.keyboard.isDown("s") then
		self.rope_length = self.rope_length + self.ropespeed*dt
	end
	if love.keyboard.isDown("d") then
		dx = dx + 1
	end
	local norm = NORM(dx, dy)
	local old_vx, old_vy = self.body:getLinearVelocity()
	vx, vy = dx/norm * self.speed, dy/norm * self.speed
	
	self.shipbody:setLinearVelocity(vx, 0)
	self.body:setLinearVelocity(old_vx, old_vy)

	self.body:applyForce(0, 10)
	
	self.rope:setMaxLength(self.rope_length)
end

function Self:destruct()
	self.fixture:destroy()
	self.body:destroy()
	self.target:destroy()
	self.shipbody:destroy()
	self.body = nil
	self.fixture = nil
	self.target = nil
	self.shipbody = nil
end

function Self:draw()
	
	


	local angle = 0
	local vx, vy = self.body:getLinearVelocity()
	if vx > 0 then
		angle = -0.1
	elseif vx < 0 then
		angle = 0.1
	end

	love.graphics.line(self.shipbody:getX(), self.shipbody:getY(), self.body:getX()+1+2, self.body:getY()-8)
	love.graphics.line(self.shipbody:getX(), self.shipbody:getY(), self.body:getX()+1+2, self.body:getY()+6)
	love.graphics.line(self.shipbody:getX(), self.shipbody:getY(), self.body:getX()+1-2, self.body:getY())
	love.graphics.draw(self.kutter_img, self.shipbody:getX(), self.shipbody:getY(), angle, 1, 1, 8, 8)
	love.graphics.draw(self.netz_img, self.body:getX()+1, self.body:getY(), 0, 1, 1, 4, 8)


	love.graphics.push()
	love.graphics.translate(math.floor(self.body:getX()), math.floor(self.body:getY()) )
	love.graphics.rotate(self.body:getAngle())
	love.graphics.setColor(1, 0, 0)
	--love.graphics.polygon("line", self.shape:getPoints())


	love.graphics.setColor(1, 1, 1)
	love.graphics.pop()


end

return Self
