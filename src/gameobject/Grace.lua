local GameObject = require 'gameobject.GameObject'
local Grace = GameObject:clone("Grace")

local IMG_POWERUPS = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Projectiles/Player_donut_shot (16 x 16).png")

local SOUND_EXPLOSION = love.audio.newSource("assets/sfx/grace.wav", "static")

function Grace:onCollision(gameObject)
	if gameObject == GET("Scenemanager"):getActiveScene().player then
		self:die(true)
		self.sound:setVolume(0.3)
		if not GET("MUTE") then self.sound:play() end
		GET("Scenemanager"):getActiveScene().score = GET("Scenemanager"):getActiveScene().score +
				10 --TODO grace is sometimes not created by bullets if they die too fast
	end
end

function Grace:init(x, y)
	GameObject.init(self, x, y)
	self.x = x
	self.y = y
	self.sx = 1
	self.sy = 1
	self.w = 16 * self.sx
	self.h = 16 * self.sy

	self.sound = SOUND_EXPLOSION:clone()

	self.img = IMG_POWERUPS
	self.r = math.pi
	self.speed = 500
	self.alliance = "neutral"

	self.quad = love.graphics.newQuad(1 * 16, 0, 16, 16, 16 * 2, 16)

	self.jobs:insert(cron.after(8, self.die, self))

	self.callbacks:register("collision", self.onCollision)


	return self
end

function Grace:update(dt)
	self.jobs:update(dt)

	local dx, dy = GET("Scenemanager"):getActiveScene().player.x - self.x,
			GET("Scenemanager"):getActiveScene().player.y - self.y
	local norm = NORM(dx, dy)
	dx = dx / norm
	dy = dy / norm

	self.x = self.x + dx * dt * self.speed
	self.y = self.y + dy * dt * self.speed

	-- self:collisionResolution()
end

function Grace:draw()
	love.graphics.setColor(1, 1, 1, 0.3)
	love.graphics.draw(self.img, self.quad, self.x, self.y, 0, self.sx, self.sy, 8, 8)
	love.graphics.setColor(1, 1, 1)
	self:drawHitbox()
end

return Grace
