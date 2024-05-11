local Object = require "lua-additions.Object"
local Conductor = Object:clone("Conductor")

function ID()
	return false
end

function Conductor:init()
	Object.init(self)

	self.counter = 0
	self.counter2 = 0

	local _d = WINDOW_WIDTH / 11

	return self
end

function Conductor:update(dt)
	local h = GET("Hyperdrift")

	if h.distance > 0 then
		local intensity = h:getIntensity()
		if intensity > 0 then
			self.counter = self.counter + dt * math.log(math.max(1.3, intensity + 1))
			self.counter2 = self.counter2 + dt * math.log(math.max(1.3, intensity + 1))
		end
		if self:canSpawn() then
			local spawns = GET("Map"):getBiome():getRandomPack()
			for i, spawn in ipairs(spawns) do
				local scene_game = GET("Scenemanager"):get(Scene_Game:type())
				scene_game:insert(spawn)
			end
			--self:spawn_raw(spawn)
			self.counter = 0
		end
		--print(GET("Map"):getBiome().biome.id)
	elseif h.distance <= 0 and GET("Map").currentStar == nil and GET("Map"):getDistanceToNearest() <= 0.1 then
		local Planet = Spawn(Planet, 1, nil)
		GET("Map").currentStar = self:spawn_raw(Planet)
		self.counter = 0
	end
end

function Conductor:canSpawn()
	return self.counter > 1.5--todo: make this value part of statsheet
end

function Conductor:spawnPack(spawn)
	local quantity = math.random(0, 3) + math.random(1, 2)
	for i = 1, quantity, 1 do
		self:spawn(spawn) --TODO set x position to same
	end

	return self
end

function Conductor:spawn_raw(spawn)
	local scene_game = GET("Scenemanager"):get(Scene_Game:type())
	local spawn_instance = spawn.gameObjectType:new(spawn.x, spawn.y)
	scene_game:insert(spawn_instance)
	return spawn_instance
end

function Spawn(go_type, quantity, x, y)
	local self = {}

	self.gameObjectType = go_type
	self.quantity = quantity
	self.x = x
	self.y = y or -40

	return self
end

return Conductor
