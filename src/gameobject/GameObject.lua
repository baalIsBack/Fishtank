local Super = require 'lua-additions.Object'
local Self = Super:clone("GameObject")

Self.shape = love.physics.newRectangleShape(1, 1)
Self.NULL_SPACE_COORDINATE = -100

function Self:init(x, y)
	Super.init(self, x, y)
	self.callbacks:declare("killed")
	self.callbacks:declare("death")
	self.callbacks:declare("destroy")
	self.callbacks:declare("collision")

	self.body = love.physics.newBody(GET("World"), x, y, "dynamic")
	self.body:setAngle(math.pi/2)
	self.body:setAngularDamping(0.2)
	--self.shape = nil
	self.fixture = love.physics.newFixture(self.body, self.shape)--TODO density?
	self.fixture:setUserData(self)
	self.sx = 1
	self.sy = 1
	self.w = 16 * self.sx
	self.h = 16 * self.sy

	self.damping = 0
	self.body:setLinearDamping(self.damping)
	self.body:setAngularDamping(0.7)

	self.rotationModifier = 1
	self.rotationalDamping = 5
	self.linearDamping = 100
	self.linearModifier = 150
	self.distanceMovementShutoff = 8


	self.target = love.physics.newBody(GET("World"), x, y, "kinematic")

	self.alliance = "good"
	return self
end

function Self:destruct()
	self.fixture:destroy()
	self.body:destroy()
	self.target:destroy()
	self.body = nil
	self.fixture = nil
	self.target = nil
end

function Self:moveToTarget(dt)
	if self.target:getX() ~= self.NULL_SPACE_COORDINATE or self.target:getY() ~= self.NULL_SPACE_COORDINATE then
		self.body:setAngularDamping(self.rotationalDamping)
		local angle = -math.atan2 ( self.target:getY() - self.body:getY(), self.target:getX() - self.body:getX() )
		local angleAway = math.atan2 ( -self.target:getY() + self.body:getY(), -self.target:getX() + self.body:getX() )
		


		local rotationAngle = (angle-self.body:getAngle())
		if math.abs(rotationAngle) > math.pi then
			local sign = SIGN(rotationAngle)
			rotationAngle = sign * ( ((rotationAngle+math.pi) % (2*math.pi)) - math.pi )
		end

		self.body:applyAngularImpulse(dt*rotationAngle*self.rotationModifier )
		

		local dist = DIST(self.body:getX(), self.body:getY(), self.target:getX(), self.target:getY())
		
		angle = self.body:getAngle()
		if dist >= self.distanceMovementShutoff then
			self.body:setLinearDamping( 0 )
			self.body:applyForce( self.linearModifier * math.cos( angle )*dt, self.linearDamping * -math.sin(angle)*dt)
		else
			self.body:setLinearDamping( self.linearDamping/(dist/10) )
			--self.body:setLinearVelocity( 0, 0 )
		end

	end
end

function Self:setTarget(target)
	self.target:setX(target.body:getX())
	self.target:setY(target.body:getY())
end

function Self:targetClosestEnemy()
	local closestEnemy = self:getClosestEnemy()
	if closestEnemy ~= nil then
		self:setTarget(closestEnemy)
		return true
	end
	return false
end

function Self:targetFront(distance)
	local dist = distance or 1000
	local angle = self.body:getAngle()
	self.target:setX(self.body:getX()+1000*math.cos(angle))
	self.target:setY(self.body:getY()-1000*math.sin(angle))
	return true
end

function Self:targetPlayer()
	local player = GET("Scenemanager"):getActiveScene().player
	if player then
		self:setTarget(player)
		return true
	end
	return false
end

function Self:getClosestEnemy()
	local gameObjects = GET("Scenemanager"):getActiveScene().contents
	local closestGameObject = nil
	local closestDistance = 1/0

	for i, gameObject in ipairs(gameObjects) do
		if gameObject.isEnemy then
			if DIST(self.body:getX(), self.body:getY(), gameObject.body:getX(), gameObject.body:getY()) < closestDistance then
				closestDistance = DIST(self.body:getX(), self.body:getY(), gameObject.body:getX(), gameObject.body:getY())
				closestGameObject = gameObject
			end
		end
	end

	return closestGameObject
end

function Self:drift(dt)
	local vx, vy = self.body:getLinearVelocity()
	local driftIncrement = (-vx) - DRIFT(timer)
	self.body:applyLinearImpulse(driftIncrement, 0)
end

function Self:update(dt)
	self.jobs:update(dt)
	self:moveToTarget(dt)
end

function Self:draw() end

function Self:drawRelative() end
function Self:drawAbsolute() end


--function Self:CHECK_COLLISION_QUALIFICATION(gameObject)
--	return self.alliance ~= gameObject.alliance and self.alliance and not self.noCollision and not gameObject
--			.noCollision and not gameObject.DEATH and not self.DEATH
--end

--function Self:collisionResolution()
--	FOREACH(GET("Scenemanager"):getActiveScene().contents, function(gameObject, i, self, ...)
--		if self:CHECK_COLLISION(gameObject) then
--			self.callbacks:call("collision", self, gameObject)
--			gameObject.callbacks:call("collision", gameObject, self)
--		end
--	end, self)
--end

function Self:die(wasKilled)
	self.DEATH = true
	self.KILLED = wasKilled
end

function Self:checkOutOfBounds(outOfScreen_bool)
	outOfScreen_bool = true --TODO ???
	--if outOfScreen_bool then
	return self.body:getX() - self.w / 2 > WINDOW_WIDTH or
			self.body:getX() + self.w / 2 < 0 or
			self.body:getY() - self.h / 2 > WINDOW_HEIGHT
	--self.body:getY() - self.h / 2 > WINDOW_HEIGHT -- or
	--self.body:getY() + self.h / 2 < -300
	--[[end
	return self.body:getX() + self.w / 2 > WINDOW_WIDTH or
			self.body:getX() - self.w / 2 < 0 or
			self.body:getY() + self.h / 2 > WINDOW_HEIGHT or
			self.body:getY() - self.h / 2 < 0]]
end

function Self:dieOnOOB(outOfScreen_bool)
	if self:checkOutOfBounds(outOfScreen_bool) then
		self:die()
	end
end

function Self:dieOnContact(gameObject)
	self:die(true)
end

function Self:drawHitbox()
	if GET("Debug").showHitboxes then
		love.graphics.push()
		love.graphics.translate(self.body:getX(), self.body:getY() )
		love.graphics.rotate(-self.body:getAngle())
		love.graphics.polygon("line", self.shape:getPoints())
		--love.graphics.rectangle("line",  - self.w / 2, - self.h / 2, self.w, self.h)
		love.graphics.pop()
	end
end



function Self:drawTargetHint()
	if GET("Debug").showHitboxes then
		love.graphics.circle("fill", self.target:getX(), self.target:getY(), 4, 34)
		love.graphics.line(self.body:getX(), self.body:getY(), self.target:getX(), self.target:getY())
	end
end

function Self:drawRotationHint()
	if GET("Debug").showHitboxes then
		local angle = self.body:getAngle()
		local dir_x, dir_y = math.cos(angle), -math.sin(angle)
		local length = 70
		love.graphics.line(self.body:getX(), self.body:getY(), self.body:getX()+dir_x * length, self.body:getY()+dir_y * length)
	end
end

	

function Self:rotateTo(obj, rotationMultiplier)
	
	--[[if rotationMultiplier == nil then
		self.r = math.atan2(obj.body:getY() - self.body:getY(), obj.body:getX() - self.body:getX()) + math.pi / 2
	else
		local targetRotation = math.atan2(obj.body:getY() - self.body:getY(), obj.body:getX() - self.body:getX()) + math.pi / 2
		local dr = (targetRotation - self.body:getAngle())
		self.r = self.r + dr * rotationMultiplier
	end]]
end

function Self:angleTo(obj)
	return math.atan2(obj.body:getY() - self.body:getY(), obj.body:getX() - self.body:getX()) + math.pi / 2
end

function Self:moveTo(obj, speed, dt)
	local r = self:angleTo(obj)
	local dir_x, dir_y = math.sin(r), -math.cos(r)
	local norm = NORM(dir_x, dir_y)
	dir_x, dir_y = dir_x / norm, dir_y / norm

	local vx, vy = self.body:getLinearVelocity( )
	self.body:setLinearVelocity(vx + dir_x * speed * dt, vy + dir_y * speed * dt)
end

return Self
