local Scene = require 'scene.Scene'
local Scene_Hud = Scene:clone("Scene_Hud")

local UIElement = require 'ui.atom.UIElement'

function Scene_Hud:init(manager)
	Scene.init(self, manager)

	self:insert(GET("Hud"))

	self.callbacks:register("enable", self.activate, self)
	self.callbacks:register("disable", self.deactivate, self)
	return self
end

function Scene_Hud:draw()
	if not self.enabled then
		return
	end
	love.graphics.push("all")
	love.graphics.origin()
	--TODO
	love.graphics.pop()
end

function Scene_Hud:update(dt)
	if not self.enabled then
		return
	end
	--TODO
end

return Scene_Hud
