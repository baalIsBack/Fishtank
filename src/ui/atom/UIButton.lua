local UIElement = require 'ui.atom.UIElement'
---@class UIButton: UIElement
---@field text string
local UIButton = UIElement:clone("UIButton")

local patchy = require 'patchy'

local UI_FONT = love.graphics.newFont("assets/font/spacecargo.ttf", 16)

local PATCH_OFF = patchy.load("assets/gfx/space-cargo-v1.1/buttons/btn-9-slice-off.png")
local PATCH_ON = patchy.load("assets/gfx/space-cargo-v1.1/buttons/btn-9-slice-on.png")

---@param text string Displayed text
---@param x integer Horizontal coordinate on the Grid
---@param y integer Vertical coordinate on the Grid
---@param w integer Width of Element on the Grid
---@param h integer Height of Element on the Grid
---@param onClick function Called when element is clicked
---@param ... any parameters supplied to onClick
function UIButton:init(text, x, y, w, h, onClick, ...)
	UIElement.init(self, x, y)
	self.callbacks:declare("click")
	self.w = w
	self.h = h

	self.text = text
	self.uitext = require("ui.atom.UIText"):new(self.text, x, y, w, h)
	self.uitext.backgroundColor = { r = 37 / 255, g = 44 / 255, b = 71 / 255 }

	self.enabled = true
	self.wasPressed = false
	self.down = false
	self.callbacks:register("click", onClick, ...)

	return self
end

function UIButton:update(dt)
	local x, y, w, h = self:getOpticalDimensions()
	local mx, my = getMousePosition()
	mx = mx / 2
	my = my / 2

	if love.mouse.isDown(1) then
		if CHECK_COLLISION(x, y, w, h, mx, my, 1, 1) then
			if not self.wasPressed then self.down = true end
		else
			self.down = false
		end
		self.wasPressed = true
	else
		if CHECK_COLLISION(x, y, w, h, mx, my, 1, 1) and self.wasPressed and
				self.down then
			self.callbacks:call("click", self)
		end
		self.wasPressed = false
		self.down = false
	end

	self.uitext.text = self.text
end

function UIButton:draw()
	local x, y, w, h = self:getOpticalDimensions()

	local old_font = love.graphics.getFont()
	love.graphics.setFont(UI_FONT)

	love.graphics.setColor(1, 1, 1, ALPHA)

	local img = nil
	if self.enabled and not self.down then
		self.uitext.enabled = true
	else
		self.uitext.enabled = false
	end

	love.graphics.translate(-GET("PIXEL_SIZE_W"), -GET("PIXEL_SIZE_H"))

	love.graphics.translate(x, y)
	love.graphics.scale(2, 2)
	if self.enabled and not self.down then
		PATCH_ON:draw(0, 0, (w + 3 * GET("PIXEL_SIZE_W")) / 2,
			(h + 3 * GET("PIXEL_SIZE_H")) / 2, 0)
	else
		PATCH_OFF:draw(0, 0, (w + 3 * GET("PIXEL_SIZE_W")) / 2,
			(h + 3 * GET("PIXEL_SIZE_H")) / 2, 0)
	end
	love.graphics.scale(1 / 2, 1 / 2)
	love.graphics.translate(-x, -y)

	self.uitext:draw()


	love.graphics.translate(GET("PIXEL_SIZE_W"), GET("PIXEL_SIZE_H"))
	love.graphics.setFont(old_font)

	love.graphics.setColor(1, 1, 1)

	self:drawHitbox()
end

return UIButton
