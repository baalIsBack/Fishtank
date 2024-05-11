local Super = require 'lua-additions.Object'
local Self = Super:clone("Biome")


function Self:init()
	Super.init(self)

	self.id = -1
	self.packs = {}

	self:reset()

	return self
end

function Self:reset()
	self.packs = {
		--dummy
	}
end

function Self:getRandomPack()
	assert(#self.packs > 0, "Biome pack has to contain at least one entry or is abstract.")
	return WEIGHTED_RANDOM(self.packs)()
end

return Self
