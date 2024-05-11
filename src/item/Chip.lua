local Item = require 'item.Item'
local Chip = Item:clone("Chip")


local IMAGE = love.graphics.newImage("assets/gfx/460+_Futuristic_Items/All_Icons/Controller.png")

function Chip:init()
	Item.init(self, 2, 2)
	self.img = IMAGE

	self.callbacks:register("install", self.onInstall, self)
	self.callbacks:register("uninstall", self.onUninstall, self)

	return self
end

function Chip:onInstall()
	print("Chip placed")
	GET("Statsheet").fire_rate = GET("Statsheet").fire_rate + 3
end

function Chip:onUninstall()
	print("Chip removed")
	GET("Statsheet").fire_rate = GET("Statsheet").fire_rate - 3
end

return Chip
