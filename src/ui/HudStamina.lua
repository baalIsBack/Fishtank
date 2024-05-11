local UIElement = require 'ui.atom.UIElement'
local HudStamina = UIElement:clone("HudStamina")

local UI_FONT = love.graphics.newFont("assets/font/spacecargo.ttf", 16)

local patchy = require 'patchy'

function HudStamina:init(x, y, w, h)
	UIElement.init(self, x, y)
	self.callbacks:declare("click")
	self.w = w
	self.h = h

	--self.text = text
	--local x, y, w, h = self:getOpticalDimensions()
	--self.uitext = require("ui.atom.UIText"):new(self.text, x, y, w, h)
	--self.uitext.backgroundColor = { r = 37 / 255, g = 44 / 255, b = 71 / 255 }

	self.enabled = true
	self.wasPressed = false
	self.down = false

	--self.callbacks:register("click", onClick, ...)
	self.patch = patchy.load("assets/gfx/Mini Pixel Pack 3/UI objects/STAMINA_BAR_9 (58 x 18).png")

	return self
end

function HudStamina:update(dt)
	local x, y, w, h = self:getOpticalDimensions()
	local mx, my = getMousePosition()
	mx = mx / 2
	my = my / 2
end

function HudStamina:draw()
	local x, y, w, h = self:getOpticalDimensions()

	self.patch:draw(x, y, WINDOW_WIDTH, 16)
	local maxWidth = WINDOW_WIDTH - 9 * GET("PIXEL_SIZE_W")
	local widthRatio = math.min(1, 0.5)

	love.graphics.setColor(43 / 255, 201 / 255, 178 / 255)
	love.graphics.rectangle("fill", x + 4 * GET("PIXEL_SIZE_W"), y + 4 * GET("PIXEL_SIZE_H"), widthRatio * maxWidth,
		2 * GET("PIXEL_SIZE_W"))

	love.graphics.setColor(242 / 255, 241 / 255, 240 / 255)
	love.graphics.rectangle("fill", x + 4 * GET("PIXEL_SIZE_W") + widthRatio * maxWidth, y + 4 * GET("PIXEL_SIZE_H"),
		GET("PIXEL_SIZE_W"),
		2 * GET("PIXEL_SIZE_W"))
	love.graphics.setColor(1, 1, 1)

	self:drawHitbox()
end

return HudStamina
