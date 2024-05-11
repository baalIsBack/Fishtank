local Super = require 'gameobject.GameObject'
local Self = Super:clone("Player")

local IMG_SHIP = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Player ship/Player_ship (16 x 16).png")
IMG_SHIP = love.graphics.newImage("assets/gfx/GreenGirl_2.png")
local QUAD_SHIP_NEUTRAL = love.graphics.newQuad(1 * 16, 0 * 16, 16, 16, 48, 16)
local QUAD_SHIP_LEFT = love.graphics.newQuad(0 * 16, 0 * 16, 16, 16, 48, 16)
local QUAD_SHIP_RIGHT = love.graphics.newQuad(2 * 16, 0 * 16, 16, 16, 48, 16)

Self.shape = love.physics.newRectangleShape(16, 16)

local function Self_onDeath(self)
	if GET("Debug").godMode then
		self.DESTROY = false
		self.KILLED = false
	else
		local explosion = Explosion:new(self.body:getX(), self.body:getY())
		GET("Scenemanager"):getActiveScene():insert(explosion)
		explosion.callbacks:register("destroy", function(self)
			-- GET("Scenemanager"):getActiveScene().manager:switch(Scene_Menue:type())
			GET("Scene_Game"):scheduleReset()
			GET("Scene_Game").ui.enabled = true
		end)
	end
end

local function Self_onCollision(self, gameObject)
--	self:die()
end

function Self:init(x, y)
	local Boosters = require 'gameobject.Boosters'
	Super.init(self, x, y)

	self.body:setAngle(math.pi/2)
	self.body:setAngularDamping( 1 )
	self.fixture:setCategory(FIXTURE_CATEGORY("player"))
	self.fixture:setMask(FIXTURE_CATEGORY("player"))

	SET("player", self)--TODO, no singleton
	self.quad = QUAD_SHIP_NEUTRAL
	self.alliance = "good"

	self.w = self.w / 2
	self.h = self.h / 2

	self.callbacks:register("death", Self_onDeath)
	self.callbacks:register("collision", Self_onCollision)

	self.booster = Boosters:new(self)
	self.gun = Gun:new(self)

	self.graceRadius = 45



	return self
end

function Self:destruct()
	--TODO this fixes a bug where enemys target the player after he dies. maybe there is a better variant to solve this?!
end

function Self:getSpeed()
	return 110 * GET("Statsheet").movement_speed_multiplier
end

function Self:update(dt)
	self.jobs:update(dt)

	local dir_x, dir_y = calcInput()

	local angle = self.body:getAngle()
	local angle_sign = SIGN(angle - math.pi/2)
	local angle_sign2 = SIGN(angle + math.pi/2)
	local absolute_angle = math.abs((angle - math.pi/2))


	local dampingModifier = 80
	local rotSpeed = 200
	local alignModifier = 600
	if SIGN(-dir_x) == angle_sign then
		self.body:setAngularDamping(absolute_angle*dampingModifier*2)
	else
		self.body:setAngularDamping(0.2)--TODO use default
	end
	if dir_x ~= 0 then
		self.body:applyTorque(SIGN(-dir_x) * rotSpeed*2)
	else
		if absolute_angle < 10e-4 then
			self.body:setAngularVelocity(0)
		else
			self.body:setAngularVelocity(0)
			self.body:applyAngularImpulse(-(angle - math.pi/2) * alignModifier)
		end
	end


	--self.body:setAngle(SIGN(self.body:getAngle()) * math.min(math.abs(self.body:getAngle()), 0.3))

	if love.keyboard.isDown("space") then self.gun:shoot() end

	local intensity = GET("Hyperdrift"):getIntensity()
	local slowdownModifier = math.max(0.2, math.min(1, 1 - (intensity / 100)))
	
	self.body:setLinearVelocity(dir_x*self:getSpeed() * slowdownModifier, dir_y*self:getSpeed() * slowdownModifier)


	self:dieOnOOB()

	-- self:collisionResolution()

	FOREACH(GET("Scenemanager"):getActiveScene().contents,--TODO should not access contents, which is ?private
		function(gameObject, i, self, ...)
			if not gameObject.noCollision and gameObject.canGiveGrace and
					DIST(self.body:getX(), self.body:getY(), gameObject.body:getX(), gameObject.body:getY()) < self.graceRadius then
				local grace = Grace:new(gameObject.body:getX(), gameObject.body:getY())
				GET("Scenemanager"):getActiveScene():insert(grace)
				gameObject.canGiveGrace = false
			end
		end, self)

	self.booster:update(dt)
	self.gun:update(dt)
end

function Self:draw()

	local dir_x, dir_y = calcInput()
	if dir_x < 0 then
		--self.quad = QUAD_SHIP_LEFT
	elseif dir_x > 0 then
		--self.quad = QUAD_SHIP_RIGHT
	else
		self.quad = QUAD_SHIP_NEUTRAL
	end

	love.graphics.draw(IMG_SHIP, self.quad, self.body:getX(), self.body:getY(), math.pi/2-self.body:getAngle(), self.sx,
		self.sy, 8, 8)

	self:drawHitbox()
	self:drawRotationHint()
	if GET("Debug").showHitboxes then
		love.graphics.circle("line", self.body:getX(), self.body:getY(), self.graceRadius, 50)
	end

	

	self.booster:draw()
	self.gun:draw()
end

return Self
