local Super = require 'biome.Biome'
local Self = Super:clone("Biome3")

function Self:reset()
	self.packs = {
		{ 10, function()
			local Enemy = require("gameobject.enemy.Piercer")
			local pack = {}
			local _d = WINDOW_WIDTH / 11
			local _x = math.random(2, 9)
			local quantity = math.random(1, 3) + math.random(0, 2)
			for i = 1, quantity, 1 do
				table.insert(pack, Enemy:new(_x * _d, -40 * i))
			end
			return pack
		end },
		{ 10, function()
			local Enemy = require("gameobject.enemy.Piercer")
			local pack = {}
			local _d = WINDOW_WIDTH / 11
			local _x = math.random(2, 9)
			local quantity = math.random(1, 3) + math.random(0, 2)
			for i = 1, quantity, 1 do
				table.insert(pack, Enemy:new(_x * _d - 32 * quantity/2 + 32 * i, -40))
			end
			return pack
		end },
		{ 1000, function()
			local Enemy = require("gameobject.enemy.Doughnut")
			local pack = {}
			local _d = WINDOW_WIDTH / 11
			local _x = math.random(2, 9)
			local quantity = math.random(1, 2) + math.random(1, 2)
			for i = 1, quantity, 1 do
				_x = math.random(2, 9)
				table.insert(pack, Enemy:new(_x * _d,  math.random(-20, 20) -80 - i*math.random(80, 120)))
			end
			return pack
		end },
		{ 5, function()
			local Enemy = require("gameobject.enemy.Circle")
			local pack = {}
			local _d = WINDOW_WIDTH / 11
			local _x = math.random(2, 9)
			local quantity = math.random(0, 1) + math.random(0, 1) + math.random(0, 2) + math.random(1, 2)
			local dx, dy = nil, nil
			local initialRotation = math.random(0, 2*math.pi * 1000)/1000
			for i = 1, quantity, 1 do
				dx, dy = POLAR2CARTESIAN(initialRotation + i * 2*math.pi / quantity, 30)
				table.insert(pack, Enemy:new(_x * _d + dx,  -80 + dy))
			end
			return pack
		end },
		{ 5, function()
			local Enemy = require("gameobject.enemy.Square")
			local pack = {}
			local _d = WINDOW_WIDTH / 11
			local _x = math.random(2, 9)
			local quantity = math.random(1, 2) + math.random(1, 2)
			for i = 1, quantity, 1 do
				_x = math.random(2, 9)
				table.insert(pack, Enemy:new(_x * _d,  -80 - i*math.random(80, 120)))
			end
			return pack
		end },
		{ 4, function()
			local Enemy = require("gameobject.enemy.Rhombus")
			local pack = {}
			local _d = WINDOW_WIDTH / 11
			local _x = math.random(2, 9)
			local quantity = math.random(1, 2) + math.random(1, 2)
			for i = 1, quantity, 1 do
				_x = math.random(2, 9)
				table.insert(pack, Enemy:new(_x * _d,  -80 - i*math.random(80, 120)))
			end
			return pack
		end },
		{ 40000, function()
			local Enemy = require("gameobject.enemy.Circle")
			local pack = {}
			local _d = WINDOW_WIDTH / 11
			local _x = math.random(2, 9)
			local quantity = 1
			for i = 1, quantity, 1 do
				_x = math.random(2, 9)
				table.insert(pack, Enemy:new(_x * _d,  200+-80 - i*math.random(80, 120)))
			end
			return pack
		end },
	}
end

return Self
