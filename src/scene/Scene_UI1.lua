local Scene_UI = require 'scene.Scene_UI'
local Scene_UI1 = Scene_UI:clone("Scene_UI1")

local UIElement = require 'ui.atom.UIElement'

function Scene_UI1:init(manager)
	Scene_UI.init(self, manager)

	self.contents = {}

	self.hud = GET("Hud")

	self:insertUIDefault()
	self.map = require("ui.UIMap"):new(-3, 2)
	self:insert(self.map)

	self.wasDown = false

	self.callbacks:register("enable", self.enable, self)
	self.callbacks:register("disable", self.disable, self)
	return self
end

return Scene_UI1
