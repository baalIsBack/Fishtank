local GameObject = require 'gameobject.GameObject'
local Planet = GameObject:clone("Planet")

--local IMG_PLANET1 = love.graphics.newImage("assets/gfx/planet-generator/2145899259.png") --100x10
SIZE = 200


function Planet:init(x, y)
	self.distanceForScreen = 500


	local _x, _y = x or math.random(-50 + WINDOW_WIDTH / 2, 50 + WINDOW_WIDTH / 2),
			y or (-120)
	GameObject.init(self, _x, _y)
	self.sx = 1
	self.sy = 1
	self.w = 128 * self.sx
	self.h = 128 * self.sy

	--self.img = IMG_PLANET1
	--local quads = Prototype:new()

	self.planetgenerator = require("PlanetGenerator"):new(self.x, self.y)

	--[[for y = 0, (self.img:getHeight() / SIZE) - 1, 1 do
    for x = 0, (self.img:getWidth() / SIZE) - 1, 1 do
      table.insert(quads,
        love.graphics.newQuad(x * SIZE, y * SIZE, SIZE, SIZE, self.img:getWidth(),
          self.img:getHeight()))
    end
  end]]


	self.sx = 1
	self.sy = 1
	self.fixture:getBody():setType("kinematic")

	--self.animation = Animation:new(10, quads, true)
	self.jobs:insert(self.animation)
	self.jobs:insert(cron.every(0.3, self.dieOnOOB, self, true))
	self.callbacks:register("destroy", function() GET("Map").currentStar = nil end)

	return self
end

function Planet:update(dt)
	local intensity = GET("Hyperdrift"):getIntensity()

	local driftSpeed = (100 + 1.6 * WINDOW_HEIGHT / self.distanceForScreen) / 5

	self:drift(dt, driftSpeed * intensity)
	self.jobs:update(dt)
	self.planetgenerator.x = self.x
	self.planetgenerator.y = self.y
	self.planetgenerator:update(dt)
	--collisionResolution etc. OOB, etc. TODO make this default and add a property to gameojects for that

	--print(self.DEATH, self.DESTROY)
end

function Planet:draw()
	self.planetgenerator:draw()
	--love.graphics.draw(self.img, self.animation:getQuad(), self.x, self.y, self.r, self.sx, self.sy, 50, 50)
end

return Planet
