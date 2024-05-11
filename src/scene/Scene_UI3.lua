local Scene_UI = require 'scene.Scene_UI'
local Scene_UI3 = Scene_UI:clone("Scene_UI3")

local UIElement = require 'ui.atom.UIElement'

function Scene_UI3:init(manager)
	Scene_UI.init(self, manager)

	self.contents = {}

	self.hud = GET("Hud")

	self:insertUIDefault()

	self:insert(require("ui.atom.UIButton"):new("X", UIElement.LEFT + 1, UIElement.TOP + 3, 1, 1, function(self)
		SET("MUTE", not GET("MUTE"))
		if GET("MUTE") then
			self.text = "X"
		else
			self.text = ""
		end
	end))
	self:insert(
		require("ui.atom.UIText"):new("Mute", UIElement.LEFT + 2, UIElement.TOP + 3, 6, 1)
		:setBackground(true)
		:align("LEFT")
	)

	self:insert(require("ui.atom.UIButton"):new(" ", UIElement.LEFT + 1, UIElement.TOP + 4, 1, 1, function(self)
		GET("Debug"):toggleHitboxes()
		if GET("Debug").showHitboxes then
			self.text = "X"
		else
			self.text = ""
		end
	end))
	self:insert(
		require("ui.atom.UIText"):new("Toggle Hitboxes", UIElement.LEFT + 2, UIElement.TOP + 4, 6, 1)
		:setBackground(true)
		:align("LEFT")
	)

	self:insert(require("ui.atom.UIButton"):new(" ", UIElement.LEFT + 1, UIElement.TOP + 5, 1, 1, function(self)
		GET("Debug"):toggleGodmode()
		if GET("Debug").godMode then
			self.text = "X"
		else
			self.text = ""
		end
	end))
	self:insert(
		require("ui.atom.UIText"):new("Toggle Godmode", UIElement.LEFT + 2, UIElement.TOP + 5, 6, 1)
		:setBackground(true)
		:align("LEFT")
	)

	self.wasDown = false

	self.callbacks:register("enable", self.enable, self)
	self.callbacks:register("disable", self.disable, self)
	return self
end

return Scene_UI3
