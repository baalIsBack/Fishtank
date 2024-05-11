local Gun = Prototype:clone("Gun")

local SOUND_SHOOT = love.audio.newSource("assets/sfx/Laser_Shoot6.wav", "static")

local function Gun_unlock(self)
	self.locked = false
end

function Gun:init(parent)
	self.sound_shoot = SOUND_SHOOT:clone()
	self.sound_shoot:setVolume(0.3)
	self.parent = parent
	self.speed = 1.3131 * GET("Statsheet").fire_rate

	self.locked = false
	self.job = cron.after(1 / self.speed, Gun_unlock, self)
	return self
end

function Gun:draw() end

function Gun:update(dt)
	self.speed = 1 / (3 - (GET("Statsheet").fire_rate + 20) / 10)
	self.job:update(dt)
end

function Gun:shoot()
	if self.locked then
		return false
	end
	self.locked = true
	local s = 1 / self.speed
	self.job = cron.after(s, Gun_unlock, self)
	self.job:reset()


	self:spawnBullet()


	return true
end

function Gun:spawnBullet()--TODO add recoil via impulse
	local Missile = require("gameobject.projectile.Missile")

	local offsetDistance = 8
	local angle = self.parent.body:getAngle()
	local offsetX, offsetY = math.cos(angle) * offsetDistance, -math.sin(angle) * offsetDistance

	local bullet = Missile:new(self.parent, self.parent.body:getX() + offsetX, self.parent.body:getY() + offsetY, self.parent.body:getAngle())
	if bullet.fixture:getMask() ~= nil then
		bullet.fixture:setMask(bullet.fixture:getMask(), FIXTURE_CATEGORY("player"))
	else
		bullet.fixture:setMask(FIXTURE_CATEGORY("player"))
	end

	self.parent.scene:insert(bullet)
	
	self.sound_shoot:stop()
	if not GET("MUTE") then
		self.sound_shoot:play()
	end
end

function Gun:spawnBullet2()
	local bullet = Bullet:new(self.parent, self.parent.x + 4, self.parent.y, self.parent.r)
	self.parent.scene:insert(bullet)

	local bullet2 = Bullet:new(self.parent, self.parent.x - 4, self.parent.y, self.parent.r)
	self.parent.scene:insert(bullet2)

	self.sound_shoot:stop()
	if not GET("MUTE") then
		self.sound_shoot:play()
	end
end

return Gun
