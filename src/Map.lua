local Object = require 'lua-additions.Object'
local Map = Object:clone("Map")
Map.BIOMES = {}
local function ADD_BIOME(biome)
	local b = biome
	table.insert(Map.BIOMES, b)
	b.id = #Map.BIOMES
end
--ADD_BIOME(require("biome.Biome"):new())
--ADD_BIOME(require("biome.Biome2"):new())
ADD_BIOME(require("biome.Biome3"):new())

function ID() return false end

function Map:init()
	Object.init(self)

	self.x = 0
	self.y = 0

	self.scroll_x = 0
	self.scroll_y = 0

	self.cache = {}

	self.selection_x = nil
	self.selection_y = nil

	self.DISTANCE_BETWEEN_STARS = 5
	--self:resetScroll()

	self:reset()

	self:generate()
	self.needsRender = false
	self.currentStar = nil



	return self
end

function Map:reset()
	self:resetScroll()
	self.x = 0
	self.y = 0
	self.selection_x = nil
	self.selection_y = nil
	self.cache = {}
	self.stars = {}
end

function Map:resetScroll()
	self.scroll_x = 0
	self.scroll_y = 0
end

function Map:move(x, y)
	self.x = self.x + x
	self.y = self.y + y
end

function Map:getMapSpeedPerSecond()
	return GET("Statsheet").map_speed_multiplier * GET("Hyperdrift").intensity
end



function Map:flyToSelection(dt)
	local hyperdrift = GET("Hyperdrift")
	if self:hasSelection() then
		if hyperdrift.distance > 0.001 then
			self:moveTo(self.selection.x, self.selection.y, self:getMapSpeedPerSecond() * dt)
		else
			self.x = self.selection.x
			self.y = self.selection.y
			--hyperdrift.intensity = 0
			hyperdrift.distance = 0
			self.selection = nil
		end
	end
end

function Map:select(point)
	local hyperdrift = GET("Hyperdrift")
	self.selection = point
	hyperdrift.distance = self:getDistanceToSelection()
end

function Map:selectNearest(x, y)
	local nearestObject = self:getNearestObject(x, y)
	self.nearestObject = nearestObject
	self:select(nearestObject)

	return nearestObject
end

function Map:update(dt)
	self:flyToSelection(dt)
	--self:getBiome().biome:update(dt)
end

function Map:moveTo(x, y, speed)
	local dx, dy = x - self.x, y - self.y
	local norm = math.sqrt(dx * dx + dy * dy)
	if norm == 0 then
		norm = 1
	end
	self:move(speed * dx / norm, speed * dy / norm)
	GET("Hyperdrift").distance = GET("Hyperdrift").distance - speed
end

function Map:getStars()
	return self.stars
end

function Map:hasSelection()
	return self.selection
end

function Map:getCacheX()
	return math.floor(0 + math.floor(self.x + self.scroll_x))
end

function Map:getCacheY()
	return math.floor(0 + math.floor(self.y + self.scroll_y))
end

function Map:getHotspot(x, y)
	assert(type(x) == "number")
	assert(type(y) == "number")
	local x = math.floor(x)
	local y = math.floor(y)

	local frequency = 0.1

	local hotspot_threshold = 0.7
	local hotspot_value = self:getValue(x*frequency, y*frequency)

	if hotspot_value > hotspot_threshold then
		-- check if (x,y) is local maximum to ensure no clumping(star next to star)
		local hotspot_value_neighbors = {
			self:getValue((x-1)*frequency, y*frequency),
			self:getValue((x+1)*frequency, y*frequency),
			self:getValue(x*frequency, (y+1)*frequency),
			self:getValue(x*frequency, (y-1)*frequency),

			self:getValue((x-1)*frequency, (y-1)*frequency),
			self:getValue((x-1)*frequency, (y+1)*frequency),
			self:getValue((x+1)*frequency, (y-1)*frequency),
			self:getValue((x+1)*frequency, (y+1)*frequency),
		}
		
		local is_local_maximum = true
		for i, v in ipairs(hotspot_value_neighbors) do
			if v > hotspot_value then
				is_local_maximum = false
			end
		end

		if is_local_maximum then
			return {x=x, y=y,}
		end
	end

end

function Map:forEach(f, w, h)
	assert(type(f) == "function")
	local pseudoX, pseudoY = nil, nil
	local w = w or 44 * 2
	local h = h or 44 * 2


	for x = -w / 2, w / 2, 1 do
		for y = -h / 2, h / 2, 1 do
			pseudoX = math.floor(x + math.floor(self.x + self.scroll_x))
			pseudoY = math.floor(y + math.floor(self.y + self.scroll_y))
			f(map, pseudoX, pseudoY)
		end
	end
end

function Map:generateCurrent()
	self.stars = {}
	self:forEach(function(map, x, y)
			local hotspot = self:getHotspot(x, y)
			if hotspot then
				table.insert(self.stars, hotspot)
			end
	end)
	self.needsRender = true
end



function Map:getBiome(x, y)
	local x, y = (x and math.floor(x)) or math.floor(self:getX()),
			(y and math.floor(y)) or math.floor(self:getY())
	local val = self:getValue(x, y)
	local index = math.floor(1 + (val * (#self.BIOMES-1)))
	
	return self.BIOMES[index]
end

function Map:generate()
	self:generateCurrent()
end

function Map:getX()
	return self.x + self.scroll_x
end

function Map:getY()
	return self.y + self.scroll_y
end

function Map:getCurrentValue()
	return self:getValue(math.floor(self.x) + math.floor(self.scroll_x), math.floor(self.y) + math.floor(self.scroll_y))
end

function Map:getValue(x, y, z)
	assert(type(x) == "number")
	assert(type(y) == "number")
	local z = z or 0
	local x_seed, y_seed, z_seed = 0.8374652, 0.456439143, 0.13428795
	return love.math.noise(x + x_seed, y + y_seed, z + z_seed)
end

function Map:getDistanceToSelection()
	if not self.selection then
		return 0
	end
	return DIST(self.x, self.y, self.selection.x, self.selection.y) * self.DISTANCE_BETWEEN_STARS
end

function Map:getDistanceToNearest()
	local nearest = self:getNearestObject()
	local x, y
	if nearest then
		x, y = nearest.x, nearest.y
	end
	return DIST(self.x, self.y, x or (1 / 0), y or (1 / 0)) * self.DISTANCE_BETWEEN_STARS
end

function Map:getNearestObject(x, y)
	local x, y = x, y
	if not x then
		x = self.x
	end
	if not y then
		y = self.y
	end
	local closestDist = 1 / 0
	local closestStar = nil
	for i, star in ipairs(self.stars) do
		local dist = DIST(x, y, star.x, star.y)
		if dist < closestDist and dist < 200 then
			closestDist = dist
			closestStar = star
		end
	end
	return closestStar
end

return Map
