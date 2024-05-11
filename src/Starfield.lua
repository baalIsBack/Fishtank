local GameObject = require 'gameobject.GameObject'
local Starfield = GameObject:clone("Starfield")

local IMG_STARS = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Stars(64 x 64).png")


--TODO this should be part of hyperdrift
function Starfield:init(_x, _y)
	GameObject.init(self, _x, _y)
	self.x = _x or 0
	self.y = _y or 0

	self.w = 64 * self.sx
	self.h = 64 * self.sy
	self.r = 0

	self.fixture:getBody():setType("kinematic")

	self.img = IMG_STARS
	self.quads = {}
	for x = 0, 4, 1 do
		self.quads[x] = {}
		for y = 0, 1, 1 do
			self.quads[x][y] = love.graphics.newQuad(x * 64, y * 64, 64, 64, self.img:getWidth(),
				self.img:getHeight())
		end
	end


	self.stars = {}
	for i = 1, 100 do
		table.insert(self.stars, {
			x = math.random(64, WINDOW_WIDTH - 64),
			y = math.random(64, WINDOW_HEIGHT - 64),
			dist = math.random(0, 1000) / 1000,
			qx = math.random(0, 4),
			qy = math.random(0, 1),
			r = math.random(0, 3),
			oscilationSpeed = math.random(1, 100) / (10 * 2)
		})
	end

	self.jobs:insert(cron.every(0.1, function(self)
		for i, star in ipairs(self.stars) do
			star.qy = (star.qy + 0.1 * star.oscilationSpeed) % 2
		end
	end, self))

	self.planets = {}
	--table.insert(self.planets, Planet:new(200, -100))

	self.speed = 200

	for i, planet in ipairs(self.planets) do
		planet.scene = GET("Scenemanager"):getActiveScene()
	end


	return self
end

function Starfield:update(dt)
	self.jobs:update(dt)
	local intensity = GET("Hyperdrift"):getIntensity()
	intensity = math.max(0, intensity) / 2

	self.y = self.y + (self.speed * intensity) * dt
	for i, planet in ipairs(self.planets) do
		planet:update(dt)
	end
end

function Starfield:draw()
	for i, star in ipairs(self.stars) do
		local x_pos = (self.x + star.x * self.w) % (WINDOW_WIDTH + 2 * self.w)
		local y_pos = (self.y * ((star.dist / 4)) + star.y * self.h - (self.h)) %
				(WINDOW_HEIGHT + 2 * self.h) - self.h
		love.graphics.draw(self.img, self.quads[math.floor(star.qx)][math.floor(star.qy)], x_pos, y_pos,
			self.r + star.r * math.pi / 2, self.sx, self.sy, 32, 32)
	end
	for i, planet in ipairs(self.planets) do
		planet:draw()
	end
	--love.graphics.setColor(1, 1, 1, 0.7)
end

return Starfield
