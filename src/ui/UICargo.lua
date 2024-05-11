local UIElement = require 'ui.atom.UIElement'
local UICargo = UIElement:clone("UICargo")

local BUTTON_BIG_ON_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/buttons/btn-big-on.png")
local BUTTON_BIG_OFF_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/buttons/btn-big-off.png")
local BUTTON_1x1_ON_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/buttons/btn-1x1-on.png")
local BUTTON_1x1_OFF_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/buttons/btn-1x1-off.png")
local SHIP_CARGO_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/ships/Player1_2.png")
local SELECTION_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/selection2.png")
local GRID_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/grid.png")
local SLICE_9_CARGO = "assets/gfx/space-cargo-v1.1/cargo-9-slice.png"
local SLICE_9_BACKGROUND = "assets/gfx/space-cargo-v1.1/background-9-slice.png"
local UI_FONT = love.graphics.newFont("assets/font/spacecargo.ttf", 16)

local patchy = require 'patchy'

function UICargo:init(x, y)
	UIElement.init(self, x, y)
	self.w = GET("Cargo"):getWidth()
	self.h = GET("Cargo"):getHeight()
	self.sx = 2
	self.sy = 2

	self.patch_cargo = patchy.load(SLICE_9_CARGO)
	self.patch_background = patchy.load(SLICE_9_BACKGROUND)



	return self
end

function UICargo:update(dt)
	local x, y, w, h = self:getOpticalDimensions()
	local mx, my = getMousePosition()
	mx = mx / 2
	my = my / 2

	if love.mouse.isDown(1) then
		if CHECK_COLLISION(x, y, w, h, mx, my, 1, 1) then
			if not self.wasPressed then
				self.down = true
			end
		else
			self.down = false
		end
		self.wasPressed = true
	else
		if CHECK_COLLISION(x, y, w, h, mx, my, 1, 1) and self.wasPressed and self.down then
			local slotX, slotY = math.floor((mx - x) / GET("BLOCK_SIZE_W")), math.floor((my - y) / GET("BLOCK_SIZE_H"))
			GET("Cargo"):swapWithHand(slotX, slotY)
			--GET("Cargo"):getCargoSlot(slotX, slotY)
		end
		self.wasPressed = false
		self.down = false
	end
end

function UICargo:draw()
	local x, y, w, h = self:getOpticalDimensions()

	local old_font = love.graphics.getFont()
	love.graphics.setFont(UI_FONT)

	love.graphics.setColor(1, 1, 1, ALPHA)


	love.graphics.translate((x - GET("PIXEL_SIZE_W") * 1), (y - GET("PIXEL_SIZE_H") * 1))
	love.graphics.scale(self.sx, self.sy)
	self.patch_background:draw(0, 0, (w + 3 * GET("PIXEL_SIZE_W")) / 2, (h + 3 * GET("PIXEL_SIZE_H")) / 2, 0)
	--self.patch_cargo:draw(0, 0, (w+3*GET("PIXEL_SIZE_W"))/2, (h+3*GET("PIXEL_SIZE_H"))/2, 0)
	love.graphics.scale(1 / self.sx, 1 / self.sy)
	love.graphics.translate(-(x - GET("PIXEL_SIZE_W") * 1), -(y - GET("PIXEL_SIZE_H") * 1))





	for _x = 0, self.w - 1, 1 do
		for _y = 0, self.h - 1, 1 do
			love.graphics.draw(GRID_IMAGE, x + _x * GET("BLOCK_SIZE_W") + GET("PIXEL_SIZE_W") * 0,
				y + _y * GET("BLOCK_SIZE_H") + GET("PIXEL_SIZE_H") * 0, 0, self.sx, self.sy)
		end
	end


	love.graphics.translate((x - GET("PIXEL_SIZE_W") * 1), (y - GET("PIXEL_SIZE_H") * 1))
	love.graphics.scale(self.sx, self.sy)
	--self.patch_background:draw(0, 0, (w+3*GET("PIXEL_SIZE_W"))/2, (h+3*GET("PIXEL_SIZE_H"))/2, 0)
	self.patch_cargo:draw(0, 0, (w + 3 * GET("PIXEL_SIZE_W")) / 2, (h + 3 * GET("PIXEL_SIZE_H")) / 2, 0)
	love.graphics.scale(1 / self.sx, 1 / self.sy)
	love.graphics.translate(-(x - GET("PIXEL_SIZE_W") * 1), -(y - GET("PIXEL_SIZE_H") * 1))




	love.graphics.setFont(old_font)
	love.graphics.setColor(1, 1, 1, 1)


	local cargo = GET("Cargo")
	local inventory = cargo:getInventory()
	for _x = 1, cargo:getWidth() do
		for _y = 1, cargo:getHeight() do
			local current = inventory[_x - 1][_y - 1].content
			if inventory[_x - 1][_y - 1].content ~= nil then
				love.graphics.draw(current.img, x + (_x - 1) * GET("BLOCK_SIZE_W") + GET("PIXEL_SIZE_W") * 2.5,
					y + (_y - 1) * GET("BLOCK_SIZE_H") + GET("PIXEL_SIZE_H") * 2.5, 0, self.sx / 2, self.sy / 2)
			end
		end
	end

	local mx, my = getMousePosition()
	mx = mx / 2
	my = my / 2
	if GET("hand") ~= nil then
		love.graphics.draw(GET("hand").img, mx, my, 0, self.sx / 2, self.sy / 2)
	end

	self:drawHitbox()
end

return UICargo
