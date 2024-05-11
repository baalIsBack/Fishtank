local UIElement = require 'ui.atom.UIElement'
local UIText = UIElement:clone("UIText")

local UI_FONT = love.graphics.newFont("assets/font/spacecargo.ttf", math.floor(2 * 5))

function UIText:init(text, x, y, w, h)
	UIElement.init(self, x, y)


	self.text = text
	self.enabled = true
	self.w = w or 0
	self.h = h or 0


	self.unalignedX = self.x
	self.unalignedY = self.y
	self:align("CENTER_VERTICAL")
	self:align("CENTER_HORIZONTAL")

	self.backgroundColor = { r = 39 / 255, g = 46 / 255, b = 73 / 255 }
	self.hasBlockBackground = false

	return self
end

function UIText:setBackground(enabled)
	self.hasBlockBackground = enabled
	return self
end

function UIText:getBackground()
	return self.hasBlockBackground
end

function UIText:align(dir)
	local textW, textH = UI_FONT:getWidth(self.text) + 1.25 * GET("PIXEL_SIZE_W"),
			UI_FONT:getHeight() + 1 * GET("PIXEL_SIZE_H")

	local x, y, w, h = self:getOpticalDimensions()
	local w, h = self.w * GET("BLOCK_SIZE_W") + 1, self.h * GET("BLOCK_SIZE_H") + 1

	if dir == "CENTER_HORIZONTAL" then
		self.x_draw = x + w / 2 + 2 * GET("PIXEL_SIZE_W") - textW / 2
	elseif dir == "CENTER_VERTICAL" then
		self.y_draw = y + h / 2 + 1 * GET("PIXEL_SIZE_H")
	elseif dir == "TOP" then
		self.y_draw = y + 4 * GET("PIXEL_SIZE_H")
	elseif dir == "BOTTOM" then
		self.y_draw = y + h - textH + 3.5 * GET("PIXEL_SIZE_H")
	elseif dir == "LEFT" then
		self.x_draw = x + 2 * GET("PIXEL_SIZE_W")
	elseif dir == "RIGHT" then
		self.x_draw = x + w - textW + GET("PIXEL_SIZE_W")
	end
	return self
end

function UIText:draw()
	local pixelSizeX, pixelSizeY = (UI_FONT:getWidth("a")) / 4, (UI_FONT:getHeight()) / 5
	local textW, textH = UI_FONT:getWidth(self.text) + 1.25 * pixelSizeX, UI_FONT:getHeight() + 1 * pixelSizeY


	local old_font = love.graphics.getFont()
	love.graphics.setFont(UI_FONT)


	if self.hasBlockBackground then
		local x, y, w, h = self:getOpticalDimensions()
		love.graphics.setColor(self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
		local newh = (math.floor(textH / GET("BLOCK_SIZE_H")) + 1) *
				GET("BLOCK_SIZE_H")
		love.graphics.rectangle("fill", x + GET("PIXEL_SIZE_W"), y + GET("PIXEL_SIZE_H"), w - GET("PIXEL_SIZE_W"), newh - 2)
	end

	if self.enabled then
		love.graphics.setColor(177 / 255, 198 / 255, 170 / 255)
	else
		love.graphics.setColor(95 / 255, 96 / 255, 162 / 255)
	end
	love.graphics.printf(self.text, math.floor(self.x_draw), math.floor(self.y_draw - textH / 2), textW)

	love.graphics.setFont(old_font)
	love.graphics.setColor(1, 1, 1)
end

return UIText
