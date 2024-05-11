local Scene = require 'scene.Scene'
local Hud = Scene:clone("Hud")

local UIElement = require 'ui.atom.UIElement'

function Hud:init(manager)
	Scene.init(self, manager)

	self.contents = {}

	local t = ""
	self.hud_text = require("ui.atom.UIText"):new(t, UIElement.CENTER_HORIZONTAL - 3, UIElement.CENTER_VERTICAL - 5, 5, 1)
	self.hud_text:align("LEFT")
	self.hud_text:align("TOP")
	self.hud_text:setBackground(false)
	table.insert(self.contents, self.hud_text)
	table.insert(self.contents,
		require("ui.HudLife"):new(UIElement.LEFT, UIElement.TOP, 9, 1))
	table.insert(self.contents,
		require("ui.HudStamina"):new(UIElement.LEFT, UIElement.TOP, 9, 1))

	return self
end

function Hud:draw()
	love.graphics.push("all")
	love.graphics.origin()

	love.graphics.translate(-1 + -GET("PIXEL_SIZE_W") * 1, -1 + GET("PIXEL_SIZE_H") * 1)
	ALPHA = 1
	for i, uie in ipairs(self.contents) do
		uie:draw()
	end
	love.graphics.pop()
end

function Hud:update(dt)
	local t = "Distance: " .. string.format("%07.2f", math.floor(GET("Hyperdrift").distance * 100) / 100) .. "\n"
	t = t .. "Ly/s:     " .. string.format("%07.2f", math.floor(GET("Hyperdrift").intensity * 100) / 100) .. "\n"
	--t = t .. "Combo:       x" .. math.floor(GET("Hyperdrift").combo*100)/100
	self.hud_text.text = t

	for i, uie in ipairs(self.contents) do
		uie:update(dt)
	end
end

return Hud
