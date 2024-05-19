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

	self.shipbody = love.physics.newBody(GET("World"), x, y, "dynamic")

	self.callbacks:register("collision", self.onCollision)

	self.rope_length = 10
	self.rope = love.physics.newRopeJoint( self.body, self.shipbody, self.body:getX(), self.body:getY(), self.shipbody:getX(), self.shipbody:getY(), self.rope_length, false )

	self.killsFish = true

	self.body:setLinearDamping(10)

	self.ropespeed = 20

	self.netspeed = 20

	self.sound = love.audio.newSource("assets/sfx/die.wav", "static")
	self.sound:setVolume(0.3)

	return self
end

function Self:onCollision(gameObject)
	if gameObject.killsPlayer then
		self:die()
		self.sound:play()
	end
end


function Self:update(dt)
	self.jobs:update(dt)
	local dx, dy = 0, 0
	if love.keyboard.isDown("w") then
		--self.rope_length = self.rope_length - self.ropespeed*dt
		dy = dy - 1
	end
	if love.keyboard.isDown("a") then
		dx = dx - 1
	end
	if love.keyboard.isDown("s") then
		--self.rope_length = self.rope_length + self.ropespeed*dt
		dy = dy + 1
	end
	if love.keyboard.isDown("d") then
		dx = dx + 1
	end
	local norm = NORM(dx, dy)
	local old_vx, old_vy = self.body:getLinearVelocity()
	vx, vy = dx/norm * self.netspeed, dy/norm * self.netspeed
	

	if (self.shipbody:getX() > 15 and vx < 0) or (self.shipbody:getX() < (love.graphics.getWidth()/4)-15 and vx > 0) then
		self.shipbody:setLinearVelocity(vx*5, (self.body:getY() - self.shipbody:getY())*500 * dt)
		self.body:applyForce(vx, vy)
	else
		self.shipbody:setLinearVelocity(0, (self.body:getY() - self.shipbody:getY())*500 * dt)
		self.body:applyForce(0, vy)
	end
	--self.body:setLinearVelocity(old_vx+vx/10, old_vy)

	
	
	--self.rope:setMaxLength(145)
end

function Self:destruct()
	--[[
	self.fixture:destroy()
	self.body:destroy()
	self.target:destroy()
	self.shipbody:destroy()
	self.body = nil
	self.fixture = nil
	self.target = nil
	self.shipbody = nil
	]]
end

function Self:draw()
	
	


	local angle = 0
	local vx, vy = self.body:getLinearVelocity()
	if vx > 0 then
		angle = -0.1
	elseif vx < 0 then
		angle = 0.1
	end

	love.graphics.line(self.shipbody:getX(), 11, self.body:getX()+1+2, self.body:getY()-8)
	--love.graphics.line(self.shipbody:getX(), 11, self.body:getX()+1+2, self.body:getY()+6)
	love.graphics.line(self.shipbody:getX(), 11, self.body:getX()+1-2, self.body:getY())
	--love.graphics.circle("line", self.shipbody:getX(), self.shipbody:getY(), 4, 100)
	love.graphics.draw(self.kutter_img, self.shipbody:getX(), 11, angle, 1, 1, 8, 8)
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
