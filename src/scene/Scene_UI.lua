local Scene = require 'scene.Scene'
local Scene_UI = Scene:clone("Scene_UI")

local UIElement = require 'ui.atom.UIElement'

function Scene_UI:init(manager)
	Scene.init(self, manager)

	self.contents = {}

	self.callbacks:register("enable", self.enable, self)
	self.callbacks:register("disable", self.disable, self)
	return self
end

function Scene_UI:draw()
	if not self.enabled then
		return
	end
	love.graphics.push("all")
	love.graphics.origin()
	ALPHA = 1
	for i, uie in ipairs(self:getContents()) do
		if uie == GET("Hud") then
			local backgroundState = uie.hud_text:getBackground()
			uie.hud_text:setBackground(true)--TODO what is this?
			uie:draw()
			uie.hud_text:setBackground(backgroundState)
		else
			uie:draw()
		end
	end
	love.graphics.pop()
end

function Scene_UI:update(dt)
	if not self.enabled then
		return
	end
	for i, uie in ipairs(self:getContents()) do
		uie:update(dt)
	end
end

function Scene:insertUIDefault()
  local UIElement = require("ui.atom.UIElement")
  self:insert(require("ui.UIBackground"):new())
  self:insert(
    require("ui.atom.UIButton"):new("R", UIElement.RIGHT - 1, UIElement.TOP + 1, 1, 1,
      function(button)
      	GET("Scenemanager"):nextUI()
      end))
  self:insert(
    require("ui.atom.UIButton"):new("L", UIElement.LEFT + 1, UIElement.TOP + 1, 1, 1,
      function(button)
        GET("Scenemanager"):previousUI()
      end))
end

return Scene_UI
