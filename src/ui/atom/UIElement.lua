local Object = require 'lua-additions.Object'
---@class UIElement: Object
local UIElement = Object:clone("UIElement")

local UI_FONT = love.graphics.newFont("assets/font/spacecargo.ttf", math.floor(2 * 5))
UIElement.TOP = -7
UIElement.BOTTOM = 6
UIElement.LEFT = -6
UIElement.RIGHT = 6
UIElement.CENTER_HORIZONTAL = 0
UIElement.CENTER_VERTICAL = 0


function UIElement:init(x, y)
	Object.init(self, x, y)

	self.x = x
	self.y = y
	self.sx = 1
	self.sy = 1
	self.w = 16 * self.sx
	self.h = 16 * self.sy


	return self
end

function UIElement:update(dt) end

function UIElement:draw() end

function UIElement:getOpticalDimensions()
	local x, y = self:calculatePosition(self.x, self.y)
	local w, h = self.w * GET("BLOCK_SIZE_W"), self.h * GET("BLOCK_SIZE_H")
	return x, y, w, h
end

function UIElement:calculatePosition(xInt, yInt)
	local middleX, middleY = (WINDOW_WIDTH / 2) - GET("BLOCK_SIZE_W") / 2, (WINDOW_HEIGHT / 2) - GET("BLOCK_SIZE_H") / 2
	return (xInt) * GET("BLOCK_SIZE_W") + middleX - 1,
			(yInt) * GET("BLOCK_SIZE_H") + middleY - 1
end

function UIElement:drawHitbox()
	local x, y, w, h = self:getOpticalDimensions()
	if GET("Debug").showHitboxes then
		love.graphics.rectangle("line", x, y, w, h)
		--love.graphics.points(x, y, x + w, y, x, y + h, x + w, y + h)
	end
end

return UIElement
