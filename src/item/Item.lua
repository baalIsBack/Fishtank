local Object = require 'lua-additions.Object'
local Item = Object:clone("Item")

local THING_IMAGE = love.graphics.newImage("assets/gfx/460+_Futuristic_Items/All_Icons/Dark Orange Alien Helmet.png")

function Item:init(w, h)
	Object.init(self)
  self.callbacks:declare("install")
  self.callbacks:declare("uninstall")

  self.w = w
  self.h = h
  self.img = THING_IMAGE

	return self
end

return Item