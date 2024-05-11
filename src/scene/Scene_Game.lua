local Scene = require 'scene.Scene'
local Scene_Game = Scene:clone("Scene_Game")

--local MUSIC_MAIN_GAME = love.audio.newSource("assets/sfx/ACTION PACK 1 OGG/Magic Fx 7.ogg", "stream")
local TILESET = love.graphics.newImage("assets/gfx/NES Underwaterlands Files/Underwaterlands_8x8_128x128.png")
local quads = {
	love.graphics.newQuad(1*8, 0*8, 8, 8, TILESET),--sky
	love.graphics.newQuad(2*8, 1*8, 8, 8, TILESET),--water top
	love.graphics.newQuad(4*8, 1*8, 8, 8, TILESET),--water top2
	love.graphics.newQuad(3*8, 1*8, 8, 8, TILESET),--water abyss1
	love.graphics.newQuad(5*8, 1*8, 8, 8, TILESET),--water abyss2
	love.graphics.newQuad(1*8, 1*8, 8, 8, TILESET),
}

function Scene_Game:init(manager)
	Scene.init(self, manager)


	SET("driftspeed", 0)
	SET("isPlaying", true)

	self.world = GET("World")

	self.objects = {}
	SET("OBJECTS", self.objects)

	self.canvas = self:createCanvas()
	self.scroll_x = 0

	table.insert(self.objects, require("gameobject.Player"):new(100, 100))

	
	
	self.canvas2 = love.graphics.newCanvas(love.graphics.getWidth()/4, love.graphics.getHeight()/4)
end

function Scene_Game:createCanvas()
	local canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setCanvas(canvas)
	love.graphics.setBackgroundColor(16/255, 115/255, 235/255)
	local waterstartOffset = 2
	local abyssOffset = 20.5
	for i=0, 40, 1 do
		for y=0, waterstartOffset, 1 do
			love.graphics.draw(TILESET, quads[1], i*8, y*8)
		end
		love.graphics.draw(TILESET, quads[2], i*8, (0+waterstartOffset)*8)
		love.graphics.draw(TILESET, quads[3], i*8, (1+waterstartOffset)*8)
		love.graphics.draw(TILESET, quads[4], i*8, (abyssOffset)*8)
		love.graphics.draw(TILESET, quads[5], i*8, (abyssOffset+1)*8)
	end
	love.graphics.setCanvas()
	return canvas
end

function Scene_Game:draw()
	--love.graphics.scale(4, 4)


	
	
	love.graphics.setCanvas(self.canvas2)
	love.graphics.clear()

	love.graphics.draw(self.canvas, (self.scroll_x)%(love.graphics.getWidth()/4))
	love.graphics.draw(self.canvas, (self.scroll_x)%(love.graphics.getWidth()/4) - love.graphics.getWidth()/4)


	for i, v in ipairs(self.objects) do
  	v:draw()
	end
	love.graphics.setCanvas()
	love.graphics.draw(self.canvas2, 0, 0, 0, 4, 4)
end
TRASH_COUNTER = 0
FISH_COUNTER = 0
function Scene_Game:update(dt)
	if GET("isPlaying") then
		local driftspeed = GET("driftspeed")
		driftspeed = DRIFT(timer)
		SET("driftspeed", driftspeed)
		TRASH_COUNTER = TRASH_COUNTER + driftspeed * dt
		FISH_COUNTER = FISH_COUNTER + driftspeed * dt

		local trash_size = driftspeed
		if TRASH_COUNTER > trash_size then
			local x, y = 4 + love.graphics.getWidth()/4, math.random(32, love.graphics.getWidth()/4 - 156)
			table.insert(self.objects, require("gameobject.Trash"):new( x, y ))
			TRASH_COUNTER = TRASH_COUNTER - trash_size
		end


		local size = driftspeed
		if FISH_COUNTER > size then
			local x, y = 4 + love.graphics.getWidth()/4, math.random(32, love.graphics.getWidth()/4 - 156)
			table.insert(self.objects, require("gameobject.Fish"):new( x, y ))
			FISH_COUNTER = FISH_COUNTER - size
		end
	end

	self.scroll_x = self.scroll_x - GET("driftspeed")*dt
	self.world:update(dt)
	for i, gameObject in ipairs(self.objects) do
		gameObject:update(dt)
	end

	local gameObject = nil
	for i=#self.objects, 1, -1 do
		gameObject = self.objects[i]
		if gameObject.DEATH == true then
			gameObject.DEATH = -1
			gameObject.DESTROY = true --TODO make destroy contain the destroyer
			gameObject.callbacks:call("death", gameObject)
			table.remove(self.objects, i)
			gameObject:destruct()
		end
	end


	if love.keyboard.isDown("k") then
		if not self.wasDown then
			print("k")
		end
		self.wasDown = true
	else
		self.wasDown = false
	end

	if love.mouse.isDown(1) then
		local mx, my = love.mouse.getPosition()

		print(mx/4, my/4)
	end


end


return Scene_Game
