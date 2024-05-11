local Scene_UI = require 'scene.Scene_UI'
local Scene_UI2 = Scene_UI:clone("Scene_UI2")

local UIElement = require 'ui.atom.UIElement'

function Scene_UI2:init(manager)
	Scene_UI.init(self, manager)

	self.contents = {}

	self.hud = GET("Hud")

	self:insertUIDefault()
	self:insert(require("ui.UICargo"):new(-5, 0))
	self:insert(require("ui.UIShipInternals"):new(1, 0))

	self.wasDown = false

	self.callbacks:register("enable", self.enable, self)
	self.callbacks:register("disable", self.disable, self)
	return self
end

return Scene_UI2
