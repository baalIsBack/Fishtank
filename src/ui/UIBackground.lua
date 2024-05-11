local UIElement = require 'ui.atom.UIElement'
local UIBackground = UIElement:clone("UIBackground")

local BACKGROUND_COLOR = love.graphics.newImage("assets/gfx/space-cargo-v1.1/bg/bg-solid.png")
local BACKGROUND_GRID = love.graphics.newImage("assets/gfx/space-cargo-v1.1/bg/bg_grid2.png")
BACKGROUND_COLOR:setWrap("repeat", "repeat")
BACKGROUND_GRID:setWrap("repeat", "repeat")


function UIBackground:init()
	UIElement.init(self, 0, 0)

	self.bg_color_quad = love.graphics.newQuad(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, BACKGROUND_COLOR:getWidth(),
		BACKGROUND_COLOR:getHeight())
	self.bg_grid_quad = love.graphics.newQuad(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, BACKGROUND_GRID:getWidth(),
		BACKGROUND_GRID:getHeight())


	return self
end

function UIBackground:update(dt)

end

function UIBackground:draw()
	love.graphics.setColor(1, 1, 1, ALPHA)
	love.graphics.draw(BACKGROUND_COLOR, self.bg_color_quad, 0, 0, 0, 2, 2)
	self:drawLines()
end

function UIBackground:drawLines() --static
	love.graphics.setColor(1, 1, 1, ALPHA)
	local x, y = nil, nil
	if self then
		x, y = self:calculatePosition(self.x, self.y)
	else
		x, y = UIBackground.calculatePosition(0, 0)
	end
	local bg_grid_quad = love.graphics.newQuad(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, BACKGROUND_GRID:getWidth(),
		BACKGROUND_GRID:getHeight())
	love.graphics.draw(BACKGROUND_GRID, bg_grid_quad, x % GET("BLOCK_SIZE_W") - GET("BLOCK_SIZE_W"),
		y % GET("BLOCK_SIZE_H") - GET("BLOCK_SIZE_H"), 0, 2, 2)
end

return UIBackground
