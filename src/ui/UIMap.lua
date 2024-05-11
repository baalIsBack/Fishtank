local UIElement = require 'ui.atom.UIElement'
local UIMap = UIElement:clone("UIMap")

local BUTTON_BIG_ON_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/buttons/btn-big-on.png")
local BUTTON_BIG_OFF_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/buttons/btn-big-off.png")
local BUTTON_1x1_ON_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/buttons/btn-1x1-on.png")
local BUTTON_1x1_OFF_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/buttons/btn-1x1-off.png")
local MAP_TARGET_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/map/map-target.png")
local MAP_STAR_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/map/map-star.png")
local MAP_SELECTION_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/map/map-selection.png")
local MAP_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/map/ui-map.png")
local MAP_GRID_IMAGE = love.graphics.newImage("assets/gfx/space-cargo-v1.1/map/ui-map-grid.png")
local SLICE_9_OFF = "assets/gfx/space-cargo-v1.1/buttons/btn-9-slice-off.png"
local SLICE_9_ON = "assets/gfx/space-cargo-v1.1/buttons/btn-9-slice-on.png"
local UI_FONT = love.graphics.newFont("assets/font/spacecargo.ttf", 16)

local patchy = require 'patchy'

function UIMap:init(x, y)
	UIElement.init(self, x, y)
	self.w = 4
	self.h = 5
	self.cache = {}
	self.shader_code = [[
		uniform vec2 stars[200];
		//uniform vec3 biomes[200];
		uniform vec2 map_coords;
		float round(float x) {
			return floor(x + 0.5);
		}

		vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
		{
			vec4 pixel = Texel(texture, texture_coords);
			vec4 backgroundColor = vec4(79.0 / 255.0, 72.0 / 255.0, 122.0 / 255.0, 0);
			vec4 starColor = vec4(253.0 / 255.0, 251.0/255.0, 243.0/255.0, 1.0);
			
			/*
			vec2 localPosition = vec2(floor(texture_coords.x*45), floor(texture_coords.y*45));
			float closest = 1.0/0.0;
			float closesB = -1;
			for (int i = 0; i < biomes.length(); i++) {
				vec3 biomeCoords = biomes[i];
				vec2 biomeCoordsFixed = vec2((biomeCoords.x-floor(map_coords.x)+22), (biomeCoords.y-floor(map_coords.y)+22));
				
				if( distance(localPosition, biomeCoordsFixed) < closest ){
					closest = distance(localPosition, biomeCoordsFixed);
					closesB = biomeCoords.z;
				}
			}
			vec4 v = vec4(1, 1, 1, 1);
			if(closesB == -1){
				v = vec4(0.0, 0.0, 0.0, 1.0);
			}
			if(closesB == 0){
				v = vec4(1.0, 1.0, 1.0, 1.0);
			}
			if(closesB == 1){
				v = vec4(0.0, 0.0, 1.0, 1.0);
			}
			if(closesB == 2){
				v = vec4(1.0, 0.0, 1.0, 1.0);
			}
			if(closesB == 3){
				v = vec4(1.0, 1.0, 0.0, 1.0);
			}
			if(closesB == 4){
				v = vec4(0.0, 1.0, 1.0, 1.0);
			}*/


			for (int i = 0; i < stars.length(); i++) {
				vec2 starCoords = stars[i];
				
				if ( (starCoords.x-floor(map_coords.x)+22) == floor(texture_coords.x*45)
			&& (starCoords.y-floor(map_coords.y)+22) == floor(texture_coords.y*45)) {
					if(starCoords.x == 0 && starCoords.y == 0){
						return vec4(0, 1, 1, 1);
					}
					return starColor; // Yellow color for matching coordinates
				}
			}			
			return backgroundColor;//v;
		}
	]]
	self.shader = love.graphics.newShader(self.shader_code)
	self:sendShader()
	--local x, y, w, h = self:getOpticalDimensions()
	--self.uitext = require("ui.atom.UIText"):new(self.text, x, y, w, h)
	--self.uitext.backgroundColor = {r=37/255, g=44/255, b=71/255}

	self.enabled = true
	self.wasPressed = false
	self.down = false

	self.star_canvas = love.graphics.newCanvas(1, 1)

	self.button = require("ui.atom.UIButton"):new("", x, y, self.w, self.h - 1, self.click, self)

	self.selection_animation = require("lua-additions.Animation"):new(40,
		require("lua-additions.Animation"):quadsFromSheet(MAP_SELECTION_IMAGE, 9, 9), false)

	self:renderStars()

	self:resetCanvas()

	return self
end

function UIMap:sendShader()
	self.shader:send("map_coords", { GET("Map"):getX(), GET("Map"):getY() })
	local stars = {}
	for i, star in ipairs(GET("Map"):getStars()) do
		table.insert(stars, { star.x, star.y })
	end
	if #stars == 0 then
		
	else
		self.shader:send("stars", unpack(stars))
	end

	--[[
	local biomes = {}
	for i, biome in ipairs(GET("Map"):getBiomes()) do
		table.insert(biomes, { biome.x, biome.y, biome.biome.id })
	end
	self.shader:send("biomes", unpack(biomes))
	]]
end

function UIMap:resetCanvas()
	local x, y, w, h = self:getOpticalDimensions()
	local canvasW, canvasH = w - GET("PIXEL_SIZE_W") * 3, h - GET("BLOCK_SIZE_H") - GET("PIXEL_SIZE_H") * 3
	self.star_canvas = love.graphics.newCanvas(canvasW, canvasH)
end

function UIMap:click(button)
	local x, y, w, h = self:getOpticalDimensions()
	local mx, my = getMousePosition()
	mx = mx / 2
	my = my / 2
	local starCanvasX = self:getCanvasX()
	local starCanvasY = self:getCanvasY()
	--local mouseMapX, mouseMapY =  starCanvasX + (self.nearestObject.x-math.floor(GET("Map").x))*GET("PIXEL_SIZE_W"),
	--                              starCanvasY + (self.nearestObject.y-math.floor(GET("Map").y))*GET("PIXEL_SIZE_H")
	local a = math.floor((mx - starCanvasX) / GET("PIXEL_SIZE_W") - 22 + math.floor(GET("Map"):getX()))
	local b = math.floor((my - starCanvasY) / GET("PIXEL_SIZE_H") - 22 + math.floor(GET("Map"):getY()))
	--print(".", (mx - starCanvasX)/GET("PIXEL_SIZE_W"), math.floor(GET("Map").x)-22, a)
	self.nearestObject = GET("Map"):selectNearest(a, b)
	self.selection_animation:restart()
end

function UIMap:renderStars()
	local map = GET("Map")
	local cacheX, cacheY = map:getCacheX(), map:getCacheY()
	if self.cache[cacheX] and self.cache[cacheX][cacheY] then
		self.star_canvas = self.cache[cacheX][cacheY]
		GET("Map").needsRender = false
		--return
	end
	local canvas = love.graphics.getCanvas()
	local x, y, w, h = self:getOpticalDimensions()
	local canvasW, canvasH = w - GET("PIXEL_SIZE_W") * 3, h - GET("BLOCK_SIZE_H") - GET("PIXEL_SIZE_H") * 3
	--self.star_canvas = love.graphics.newCanvas(canvasW, canvasH)
	love.graphics.setCanvas(self.star_canvas)
	love.graphics.setColor(39 / 255, 46 / 255, 73 / 255)
	love.graphics.setShader(self.shader)

	--TODO
	--love.graphics.rectangle("fill", 0, 0, canvasW, canvasH)
	love.graphics.setShader()
	love.graphics.setCanvas(canvas)
	love.graphics.setColor(1, 1, 1)

	love.graphics.setCanvas(self.star_canvas)
	love.graphics.setColor(0.85, 1, 0.2)
	for i, star in ipairs(GET("Map"):getStars()) do
		local a, b = ((star.x - GET("Map"):getX()) + 22) * GET("PIXEL_SIZE_W"),
				((star.y - GET("Map"):getY()) + 22) * GET("PIXEL_SIZE_H")
		love.graphics.draw(MAP_STAR_IMAGE, a, b, 0, 2, 2)
	end
	love.graphics.setColor(1, 1, 1)
	love.graphics.setCanvas(canvas)

	--self:renderBiomes()

	if not self.cache[cacheX] then
		self.cache[cacheX] = {}
	end
	if not self.cache[cacheX][cacheY] then
		self.cache[cacheX][cacheY] = nil --self.star_canvas
	end
	GET("Map").needsRender = false
	print("RENDER STARS")
end

function UIMap:renderBiomes()
	local canvas = love.graphics.getCanvas()
	--local x, y, w, h = self:getOpticalDimensions()
	--local canvasW, canvasH = w - GET("PIXEL_SIZE_W") * 3, h - GET("BLOCK_SIZE_H") - GET("PIXEL_SIZE_H") * 3


	love.graphics.setCanvas(self.star_canvas)
	for _x = 0, 44, 1 do
		for _y = 0, 44, 1 do
			local x, y = (_x) * GET("PIXEL_SIZE_W"), (_y) * GET("PIXEL_SIZE_H")
			local biome = GET("Map"):getBiome(_x + GET("Map"):getX(), _y + GET("Map"):getY())
			if biome then
				love.graphics.setColor(biome.biome.color[1], biome.biome.color[2], biome.biome.color[3], 0.6)
				love.graphics.rectangle("fill", x, y, GET("PIXEL_SIZE_W"), GET("PIXEL_SIZE_H"))
			end
		end
	end

	love.graphics.setColor(1, 1, 1)
	love.graphics.setCanvas(canvas)
	print("RENDER BIOMES")
end

function UIMap:update(dt)
	local x, y, w, h = self:getOpticalDimensions()
	local mx, my = getMousePosition()
	local speed = 20
	local keyPressed = false




	self.button:update(dt)

	self.selection_animation:update(dt)

	local map = GET("Map")
	local old_scroll_x = map.scroll_x
	local old_scroll_y = map.scroll_y
	if love.keyboard.isDown("w") then
		map.scroll_y = map.scroll_y - speed * dt
		keyPressed = true
	end
	if love.keyboard.isDown("s") then
		map.scroll_y = map.scroll_y + speed * dt
		keyPressed = true
	end
	if love.keyboard.isDown("a") then
		map.scroll_x = map.scroll_x - speed * dt
		keyPressed = true
	end
	if love.keyboard.isDown("d") then
		map.scroll_x = map.scroll_x + speed * dt
		keyPressed = true
	end

	local m = 20
	if keyPressed and (math.floor(map.scroll_x / m) ~= math.floor(old_scroll_x / m) or math.floor(map.scroll_y / m) ~= math.floor(old_scroll_y / m)) then
		GET("Map"):generate()
		GET("Map").needsRender = true
		self:sendShader()
	end
end

function UIMap:getCanvasWidth()
	local _, _, w, h = self:getOpticalDimensions()
	return w - GET("PIXEL_SIZE_W") * 3
end

function UIMap:getCanvasHeight()
	local _, _, w, h = self:getOpticalDimensions()
	return h - GET("BLOCK_SIZE_H") - GET("PIXEL_SIZE_H") * 3
end

function UIMap:getCanvasWidthInPixels()
	return self:getCanvasWidth() / GET("PIXEL_SIZE_W")
end

function UIMap:getCanvasHeightInPixels()
	return self:getCanvasHeight() / GET("PIXEL_SIZE_H")
end

function UIMap:getCanvasX()
	local x, y, w, h = self:getOpticalDimensions()
	return x + GET("PIXEL_SIZE_W") * (2)
end

function UIMap:getCanvasY()
	local x, y, w, h = self:getOpticalDimensions()
	return y + GET("PIXEL_SIZE_H") * (2)
end

function UIMap:drawMapOutline()
	local x, y, w, h = self:getOpticalDimensions()
	love.graphics.draw(MAP_IMAGE, x - GET("PIXEL_SIZE_W"), y - GET("PIXEL_SIZE_H"), 0, 2, 2)
end

function UIMap:drawMapTarget()
	local x, y, w, h = self:getOpticalDimensions()
	local target_x, target_y = self:getCanvasX(), self:getCanvasY()
	love.graphics.draw(MAP_TARGET_IMAGE, target_x + GET("BLOCK_SIZE_W") * (self.w - 1) / 2,
		target_y + GET("BLOCK_SIZE_H") * (self.w - 1) / 2, 0, 2, 2)
end

function UIMap:drawMapGrid()
	local x, y, w, h = self:getOpticalDimensions()
	love.graphics.draw(MAP_GRID_IMAGE, x - GET("PIXEL_SIZE_W"), y - GET("PIXEL_SIZE_H"), 0, 2, 2)
end

function UIMap:drawStarCanvas()
	local starCanvasX, starCanvasY = self:getCanvasX(), self:getCanvasY()

	self:sendShader()

	love.graphics.setShader(self.shader)
	--love.graphics.setColor(39 / 255, 46 / 255, 73 / 255)
	love.graphics.draw(MAP_STAR_IMAGE, starCanvasX, starCanvasY, 0,
		self:getCanvasWidth(), self:getCanvasHeight())
	love.graphics.setShader()

	--love.graphics.rectangle("fill", starCanvasX, starCanvasY,
	--	self:getCanvasWidth(), self:getCanvasHeight())
end

function UIMap:drawSelector()
	local x, y, w, h = self:getOpticalDimensions()
	local target_x, target_y = self:getCanvasX(), self:getCanvasY()
	if self.nearestObject then
		local rx, ry = ((self.nearestObject.x - math.floor(GET("Map"):getX()) + 22)),
				((self.nearestObject.y - math.floor(GET("Map"):getY()) + 22))
		if (rx < 0 or rx > 44 or ry < 0 or ry > 44) then
			rx = math.max(0, math.min(44, rx))
			ry = math.max(0, math.min(44, ry))
		end
		local a, b = target_x - rx, target_y - ry
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(MAP_SELECTION_IMAGE, self.selection_animation:getQuad(), self:getCanvasX() + math.floor(rx - 4) *
			GET("PIXEL_SIZE_W"), self:getCanvasY() + math.floor(ry - 4) * GET("PIXEL_SIZE_H"), 0, 2, 2)
	end
end

function UIMap:draw()
	if GET("Map").needsRender then
		--self:renderStars()
	end

	self:drawMapOutline()
	self:drawMapGrid()
	self:drawStarCanvas()
	self:drawMapTarget()
	self:drawSelector()

	local x, y, w, h = self:getOpticalDimensions()
	local canvasW, canvasH = w - GET("PIXEL_SIZE_W"), h - GET("BLOCK_SIZE_H") - GET("PIXEL_SIZE_H")



	love.graphics.setColor(1, 1, 1)
	--love.graphics.rectangle("fill", starCanvasX, starCanvasY, self:getCanvasWidth(), self:getCanvasHeight())

	self:drawHitbox()
end

return UIMap
