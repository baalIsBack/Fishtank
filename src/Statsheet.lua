local Prototype = require 'lua-additions.Prototype'
local Statsheet = Prototype:clone("Statsheet")


function Statsheet:init()
	Prototype.init(self)

	self.player_speed = 1
	self.intensity_acceleration = 0.1
	self.magic_find = 1
	self.combo_magic_find_modifier = 1
	self.pickup_radius = 1
	self.pickup_speed = 1
	self.movement_speed_multiplier = 1
	self.fire_rate = 1
	self.fire_rate_base = 1 --TODO
	self.fire_rate_mult = 1 --TODO
	self.max_intensity = 2.5
	self.drop_modifier = 1
	self.map_speed_multiplier = 1

	return self
end

function Statsheet:getMoveSpeed()

end

function Statsheet:getMagicFind()

end

function Statsheet:getPickupRadius()

end

function Statsheet:getFireRate()

end

function Statsheet:getMagicFind()

end

return Statsheet
