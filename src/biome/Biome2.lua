local Super = require 'biome.Biome'
local Biome = Super:clone("Biome")

function ID()
	return false
end

function Spawn(go_type, after, x, y, repeating, condition)
	local self = {}

	self.gameObjectType = go_type
	self.after = after
	self.x = x
	self.y = y
	self.repeating = repeating
	self.condition = condition --function(spawn, timeTriggered) -> Bool

	return self
end

function Biome:init()
	Super.init(self)

	self.id = -1

	self.spawn = {}


	self:reset()

	return self
end

function Biome:update(dt)
end

function Biome:reset()
	local _d = WINDOW_WIDTH / 11
	self.spawn = {}
	table.insert(self.spawn, Spawn(RedDude, 0.3, _d * 5, -32, true, ID))
	table.insert(self.spawn, Spawn(GreenCount, 0.5, _d * 1, -32, true, ID))
	table.insert(self.spawn, Spawn(GreenCount, 0.5, _d * 10, -32, true, ID))
	table.insert(self.spawn, Spawn(RedDude, 0.1, _d * 5, -32, true, ID))
	table.insert(self.spawn, Spawn(GreenCount, 0.5, _d * 1, -32, true, ID))
	table.insert(self.spawn, Spawn(GreenCount, 0.5, _d * 10, -32, true, ID))
	table.insert(self.spawn, Spawn(RedDude, 0.1, _d * 5, -32, true, ID))
end

return Biome
