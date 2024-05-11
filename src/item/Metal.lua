local Item = require 'item.Item'
local Metal = Item:clone("Metal")

IMAGE_1 = love.graphics.newImage("assets/gfx/Alien Breaker/Enemies and Objects/metal_piece_1.png")

function Metal:init()
	Item.init(self, 1, 1)
	self.img = IMAGE_1

	--self.callbacks:register("install", self.onInstall, self)
	--self.callbacks:register("uninstall", self.onUninstall, self)

	return self
end

function Metal:onInstall()
	--GET("Statsheet").fire_rate = GET("Statsheet").fire_rate + 3
end

function Metal:onUninstall()
	--GET("Statsheet").fire_rate = GET("Statsheet").fire_rate - 3
end

return Metal
