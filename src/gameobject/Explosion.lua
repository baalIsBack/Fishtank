local GameObject = require 'gameobject.GameObject'
local Explosion = GameObject:clone("Explosion")

local IMG_EXPLOSION = love.graphics.newImage(
	"assets/gfx/wills_pixel_explosions_sample/round_explosion/spritesheet/spritesheet.png")
local IMG_EXPLOSION2 = love.graphics.newImage(
	"assets/gfx/wills_pixel_explosions_sample/round_vortex/spritesheet/spritesheet.png")
local IMG_EXPLOSION3 = love.graphics.newImage(
	"assets/gfx/wills_pixel_explosions_sample/vertical_explosion/spritesheet/spritesheet.png")
local IMG_EXPLOSION4 = love.graphics.newImage(
	"assets/gfx/wills_pixel_explosions_sample/vertical_explosion_small/spritesheet/spritesheet.png")
local IMG_EXPLOSION5 = love.graphics.newImage(
	"assets/gfx/wills_pixel_explosions_sample/X_plosion/spritesheet/spritesheet.png")
local IMG_EXPLOSION6 = love.graphics.newImage(
	"assets/gfx/wills_magic_pixel_particle_effects/implosion_A/spritesheet.png")
local SOUND_EXPLOSION = love.audio.newSource("assets/sfx/Explosion3.wav", "static")
function Explosion:init(x, y, opt)
	GameObject.init(self, x, y)
	self.body:setType("kinematic")
	self.body:setActive(false)
	self.img = IMG_EXPLOSION
	local quads = {}
	self.sound_explosion = SOUND_EXPLOSION:clone()
	self.sound_explosion:setVolume(0.15)
	if not GET("MUTE") then self.sound_explosion:play() end

	self.spritesize = 100

	local rand = opt or 5
	if rand == 1 then
		self.img = IMG_EXPLOSION
	elseif rand == 2 then
		self.img = IMG_EXPLOSION2
	elseif rand == 3 then
		self.img = IMG_EXPLOSION3
	elseif rand == 4 then
		self.img = IMG_EXPLOSION4
	elseif rand == 5 then
		self.img = IMG_EXPLOSION5
	elseif rand == 6 then
		self.img = IMG_EXPLOSION6
		self.spritesize = 52
	end
	for y = 0, (self.img:getWidth() / self.spritesize) - 1, 1 do
		for x = 0, (self.img:getHeight() / self.spritesize) - 1, 1 do
			table.insert(quads,
				love.graphics.newQuad(x * self.spritesize, y * self.spritesize, self.spritesize,
					self.spritesize, self.img:getWidth(), self.img:getHeight()))
		end
	end

	self.x = x
	self.y = y
	self.sx = 1
	self.sy = 1

	self.radius = 40

	self.animation = Animation:new(100, quads, false)
	if rand == 6 then
		self.animation = Animation:new(52, quads, false):reverse()
	end
	self.animation.callbacks:register("finish", function(anim)
		self.DESTROY = true
	end)
	self.jobs:insert(self.animation)
	return self
end

function Explosion:update(dt)
	self.jobs:update(dt)
	--[[
	if not self.noCollision then
		FOREACH(GET("Scenemanager"):getActiveScene().contents, function(gameObject, i, self, ...)
			if self:CHECK_COLLISION_QUALIFICATION(gameObject) then
				if DIST(self.x, self.y, gameObject.x, gameObject.y) < self.radius then
					gameObject:die()
				end
			end
		end, self)
	end
	self:drift(dt)
	]]
end

function Explosion:draw()
	love.graphics.draw(self.img, self.animation:getQuad(), self.body:getX(), self.body:getY(), 0, self.sx, self.sy,
		self.spritesize / 2, self.spritesize / 2)
	if GET("Debug").showHitboxes then
		love.graphics.circle("line", self.body:getX(), self.body:getY(), self.radius, 54)
	end
end

return Explosion
