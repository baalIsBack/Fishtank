local GameObject = require 'gameobject.GameObject'
local Powerup_Shield = GameObject:clone("Powerup_Shield")

IMG_POWERUPS = love.graphics.newImage(
	"assets/gfx/Mini Pixel Pack 3/Items/Circle_+_Square_+_Missile_pick-ups (16 x 16).png")

local function Powerup_Shield_onDestroy(self)
	--
end

local function Powerup_Shield_onCollision(self, gameObject)
	if gameObject == GET("Scenemanager"):getActiveScene().player then
		self:die(true)
		gameObject.gun.speed = gameObject.gun.speed + 0.5
	end
end

function Powerup_Shield:init(x, y)
	GameObject.init(self, x, y)
	self.x = x
	self.y = y
	self.sx = 1
	self.sy = 1
	self.w = 16 * self.sx
	self.h = 16 * self.sy

	self.img = IMG_POWERUPS
	self.r = math.pi
	self.fixture:getBody():setType("kinematic")
	self.speed = 150
	self.alliance = "neutral"

	self.quad = love.graphics.newQuad(1 * 16, 0, 16, 16, 16 * 3, 16)

	self.jobs:insert(cron.after(8, self.die, self))

	self.callbacks:register("destroy", Powerup_Shield_onDestroy)
	self.callbacks:register("collision", Powerup_Shield_onCollision)
	return self
end

function Powerup_Shield:update(dt)
	self.jobs:update(dt)

	self:drift(dt)

	-- self:collisionResolution()
end

function Powerup_Shield:draw()
	love.graphics.draw(self.img, self.quad, self.x, self.y, 0, self.sx, self.sy,
		8, 8)
	self:drawHitbox()
end

return Powerup_Shield
