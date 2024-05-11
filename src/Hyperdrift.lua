local Object = require 'lua-additions.Object'
local Hyperdrift = Object:clone("Hyperdrift")


function Hyperdrift:suitableSpawnLocation()
	return math.random(0 + 32, WINDOW_WIDTH - 32), -32
end

function Hyperdrift:init()
	local Scene_Game = require 'scene.Scene_Game'
	Object.init(self)

	self:reset()

	self.jobs:insert(cron.every(0.331972, self.decreasePrice, self))

	return self
end

function Hyperdrift:reset()
	self.intensity = 0 --[0, 1]
	self.combo = 1
	self.accumulatedIntesity = 0
	self.price_modifier = 1
	self.initialBoost = 1
	self.distance = 0
	self.shake = 0
end

function Hyperdrift:printInterface()
	love.graphics.push("all")
	love.graphics.origin()
	local combo = self:getCombo()
	local shakeMod = combo / 100
	love.graphics.setColor(1, 0.95 - combo / 50, 0.95 - combo / 50)
	local texts = {}

	for i, text in ipairs(texts) do
		love.graphics.print(text, 10, 10 + 30 * (i - 1), self.shake * shakeMod)
	end

	love.graphics.pop()
end

function Hyperdrift:draw()
	self:printInterface()

	local intensity = (math.max(0, math.max(9.5, self:getIntensity()) - 9.5))
	local x, y = WINDOW_WIDTH / 2, WINDOW_HEIGHT

	local random_direction_x, random_direction_y = math.random(-1000, 1000) / 1000, math.random(-1000, 1000) / 1000
	love.graphics.translate(random_direction_x * intensity, random_direction_y * intensity)

	love.graphics.translate(WINDOW_WIDTH / 2, 0)
	love.graphics.scale(1 - intensity / 3000, 1 - intensity / 1000)
	love.graphics.translate(-WINDOW_WIDTH / 2, -0)
end

function Hyperdrift:decreasePrice()
	self.price_modifier = math.sqrt(self.price_modifier)
end

function Hyperdrift:spawnLoot()
	local Metal = require 'gameobject.loot.Metal'
	--TODO quality = (30*10)+200/((math.max(1, self.intensity)/5) *self.combo/9)
	if GET("Scenemanager"):getActiveScene():type() == Scene_Game:type() then
		local chance = (15 * 10) +
				200 /
				((math.max(1, (self.intensity / 3) * math.max(1, self.combo * GET("Statsheet").combo_magic_find_modifier))))

		for i = 1, math.floor(self.intensity / 10), 1 do
			chance = chance - 30 / (i / 2)
		end

		local r = math.random(1, chance)
		if math.floor(r) == math.floor(chance) or love.keyboard.isDown("f3") then
			local scene_game = GET("Scenemanager"):get(Scene_Game:type())
			local x, y = suitableSpawnLocation()
			scene_game:insert(Metal:new(x, y))
		end
	end
end

function Hyperdrift:spawnEnemy(justDoIt)
	if self.intensity > 0 then
		local scene_game = GET("Scenemanager"):get(Scene_Game:type())
		local cost = 0.5


		local enemysMajor = { Alan, Lips, BonBon }
		local enemysMinor = { Clapper, GreenCount, Octo, Parasite, RedDude, Robo, YellaFella, }


		if justDoIt or self.accumulatedIntesity > (self.price_modifier) / 5 then
			local r = math.random(1, 3)
			local x, y = suitableSpawnLocation()
			if r == 1 then
				scene_game:insert(enemysMajor[math.random(1, #enemysMajor)]:new(x, y))
				self.accumulatedIntesity = self.accumulatedIntesity - 3
			else
				scene_game:insert(enemysMinor[math.random(1, #enemysMinor)]:new(x, y))
				self.accumulatedIntesity = self.accumulatedIntesity - 1
			end
			self.price_modifier = self.price_modifier * 2
		end

		self.accumulatedIntesity = math.max(0, self.accumulatedIntesity)
	end
end

function Hyperdrift:updateCombo(dt)
	local _, acceleration = calcInput()
	if acceleration < 0 then
		if self:hasCombo() then
			self.combo = self.combo + 0.1 * dt
			self.combo = self.combo * math.pow(1.0001, dt)
		end
	elseif acceleration > 0 then
		self.combo = math.max(1, self.combo - 0.1 * dt)
	else
		if self.intensity > 1 then
			self.combo = math.max(1, self.combo - 0.33 * dt)
		end
	end
end

function Hyperdrift:decelerate(dt)
	local statsheet = GET("Statsheet")
	self.intensity = self.intensity - 3 * statsheet.intensity_acceleration * dt
	self.intensity = math.max(0, self.intensity)
end

function Hyperdrift:accelerate(dt)
	local statsheet = GET("Statsheet")
	self.intensity = self.intensity + statsheet.intensity_acceleration * dt
	self.intensity = math.min(statsheet.max_intensity, self.intensity)
end

function Hyperdrift:updateIntensity(dt)
	local accelerationKeyDown = love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")
	local decelerationKeyDown = love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")
	if (decelerationKeyDown or self:isLanding()) and not self:isLandingSequence() then
		local mod = 1
		if self:isLanding() then
			mod = 3
		end
		self:decelerate(mod * dt)
	elseif (accelerationKeyDown and GET("Map").selection) or self:isLandingSequence() then
		self:accelerate(dt)
	end
end

function Hyperdrift:isLandingSequence()
	return self.distance == 0 and GET("Map").currentStar and GET("Map").currentStar.body:getY() < WINDOW_HEIGHT / 4
end

function Hyperdrift:isLanding()
	return self.distance == 0 and GET("Map").currentStar and GET("Map").currentStar.body:getY() > WINDOW_HEIGHT / 4
end

function Hyperdrift:jumpStart()
	self.intensity = 1
	self.accumulatedIntesity = self.initialBoost
	self.combo = 1.01
end

function Hyperdrift:hasCombo()
	return self.combo > 1
end

function Hyperdrift:update(dt)
	GET("Conductor"):update(dt)

	local activeScene = GET("Scenemanager"):getActiveScene()
	self.jobs:update(dt)

	local accelerationKeyDown = love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")
	if GET("Scenemanager"):getActiveScene().isScene_Game then
		self:updateIntensity(dt)
		self:updateCombo(dt)
		if GET("Map"):hasSelection() then
			if accelerationKeyDown and self.intensity == 0 then
				self:jumpStart()
			end
		end
	else
		self.intensity = math.max(self.intensity - dt * 20, 0)
	end



	GET("Map"):update(dt)
end

function Hyperdrift:getIntensity()
	return self.intensity
end

function Hyperdrift:getCombo()
	return self.combo
end

return Hyperdrift
