local GameObject = require 'gameobject.GameObject'
local Loot = GameObject:clone("Loot")

IMG_POWERUPS = love.graphics.newImage(
	"assets/gfx/460+_Futuristic_Items/Futuristic_Icons_Spritesheet.png")

local function Loot_onDestroy(self) self.callbacks:call("loot", self) end

local function Loot_onCollision(self, gameObject)
	if gameObject == GET("Scenemanager"):getActiveScene().player then
		self:die(true)
	end
end

function Loot:init(x, y)
	GameObject.init(self, x, y)
	self.callbacks:declare("loot")
	self.x = x
	self.y = y
	self.sx = 1
	self.sy = 1
	self.w = 9 * self.sx
	self.h = 9 * self.sy

	self.img = IMG_POWERUPS
	self.r = math.pi
	self.noCollision = false
	self.speed = 150
	self.alliance = "neutral"

	self.quad = love.graphics.newQuad(6 * 16, 0 * 16, 16, 16,
		self.img:getWidth(), self.img:getHeight())

	self.jobs:insert(cron.after(8, self.die, self))

	self.callbacks:register("destroy", Loot_onDestroy, self)
	self.callbacks:register("collision", Loot_onCollision)
	self.callbacks:register("loot", self.onLoot, self)

	return self
end

function Loot:update(dt)
	self.jobs:update(dt)

	if self:inPlayerPickupRadius() then
		self:moveTo(GET("player"),
			GET("Statsheet").pickup_speed * 200, dt)
	else
		self:drift(dt)
	end

	-- self:collisionResolution()
end

function Loot:inPlayerPickupRadius() -- TODO fix this; only works for one
	return
			DIST(self.x, self.y, GET("player").x, GET("player").y) <
			GET("Statsheet").pickup_radius * 20
end

function Loot:draw()
	if self.quad then
		love.graphics.draw(self.img, self.quad, self.x, self.y, 0, self.sx,
			self.sy, 8, 8)
	else
		love.graphics.draw(self.img, self.x, self.y, 0, self.sx, self.sy, 8, 8)
	end
	self:drawHitbox()
end

function Loot:setImage(img, quad)
	self.img = img
	self.quad = quad
end

function Loot:onLoot()
	local cargo = GET("Cargo")
	local item = require("item." .. self:type()):new()
	cargo:insert(item)
	item.img = self.img
end

return Loot
