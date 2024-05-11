local UIElement = require 'ui.atom.UIElement'
local HudLife = UIElement:clone("HudLife")

local UI_FONT = love.graphics.newFont("assets/font/spacecargo.ttf", 16)

local patchy = require 'patchy'

function HudLife:init(x, y, w, h)
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
	self.patch = patchy.load("assets/gfx/Mini Pixel Pack 3/UI objects/HP_BAR_9 (58 x 18).png")
	self.hp = 0

	return self
end

function HudLife:update(dt)
	local mx, my = getMousePosition()
	mx = mx / 2
	my = my / 2
	self.hp = math.min(1, self.hp + dt / 10)
end

function HudLife:draw()
	local x, y, w, h = self:getOpticalDimensions()


	self.patch:draw(x, y, WINDOW_WIDTH, 16)
	local maxWidth = WINDOW_WIDTH - 5 * GET("PIXEL_SIZE_W")
	local widthRatio = math.min(1, self.hp)

	love.graphics.setColor(255 / 255, 70 / 255, 0 / 255)
	love.graphics.rectangle("fill", x + 2 * GET("PIXEL_SIZE_W"), y, widthRatio * maxWidth,
		2 * GET("PIXEL_SIZE_W"))

	love.graphics.setColor(255 / 255, 196 / 255, 31 / 255)
	love.graphics.rectangle("fill", x + 2 * GET("PIXEL_SIZE_W") + widthRatio * maxWidth, y, GET("PIXEL_SIZE_W"),
		2 * GET("PIXEL_SIZE_W"))
	love.graphics.setColor(1, 1, 1)

	self:drawHitbox()
end

return HudLife
