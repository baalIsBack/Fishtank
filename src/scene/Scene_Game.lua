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

FONT = love.graphics.newFont("assets/fonts/Weiholmir_regular.ttf", 80)
FONT2 = love.graphics.newFont("assets/fonts/Weiholmir_regular.ttf", 20)

function Scene_Game:reset()
	SET("driftspeed", 0)
	SET("isPlaying", false)
	local oldplayer = GET("player")

	local x, y = oldplayer.body:getX(), oldplayer.body:getY()

	resetWorld()
	self.world = GET("World")
	self.objects = {}
	SET("OBJECTS", self.objects)
	table.insert(self.objects, oldplayer)
	table.insert(self.objects, require("gameobject.StartBubble"):new(200, 100))
	table.insert(self.objects, require("gameobject.ExitBubble"):new(50, 100))
	table.insert(self.objects, require("gameobject.CreditBubble"):new(30, 50))
	SET("trashmod", 1)
	SET("points", 0)
	timer = 0
	table.insert(self.objects, require("gameobject.Wall"):new(love.graphics.getWidth()/8, 0+16))
	table.insert(self.objects, require("gameobject.Wall"):new(love.graphics.getWidth()/8, 16+20.5*8))
	TRASH_COUNTER = 0
	FISH_COUNTER = 0

		

end

function Scene_Game:init(manager)
	Scene.init(self, manager)
	TRASH_COUNTER = 0
	FISH_COUNTER = 0

	self.music = love.audio.newSource("assets/sfx/mixkit-sea-waves-loop-1196.wav", "static")
	self.music:setLooping(true)
	self.music:play()
	self.music:setVolume(0.01)

	SET("SCENE", self)

	love.graphics.setFont(FONT)
	SET("driftspeed", 0)
	SET("isPlaying", false)

	self.world = GET("World")

	self.objects = {}
	SET("OBJECTS", self.objects)

	self.canvas = self:createCanvas()
	self.scroll_x = 0

	table.insert(self.objects, require("gameobject.Player"):new(100, 100))
	table.insert(self.objects, require("gameobject.StartBubble"):new(200, 100))
	table.insert(self.objects, require("gameobject.ExitBubble"):new(50, 100))
	table.insert(self.objects, require("gameobject.CreditBubble"):new(30, 50))
	SET("trashmod", 1)
	SET("points", 0)


	table.insert(self.objects, require("gameobject.Wall"):new(love.graphics.getWidth()/8, 0+16))
	table.insert(self.objects, require("gameobject.Wall"):new(love.graphics.getWidth()/8, 16+20.5*8))

	--table.insert(self.objects, require("gameobject.Fish"):new( 200,100 ))
	--table.insert(self.objects, require("gameobject.Player"):new(100, 100))

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

	if GET("isPlaying") then
	
	
		love.graphics.setCanvas(self.canvas2)
		love.graphics.clear()

		love.graphics.draw(self.canvas, (self.scroll_x)%(love.graphics.getWidth()/4))
		love.graphics.draw(self.canvas, (self.scroll_x)%(love.graphics.getWidth()/4) - love.graphics.getWidth()/4)


		for i, v in ipairs(self.objects) do
	  	v:draw()
		end
		love.graphics.setCanvas()
		love.graphics.draw(self.canvas2, 0, 0, 0, 4, 4)

		local points = math.floor(GET("points")/10)
		local highscore = math.floor(GET("Highscore").score/10)
		if points == highscore then
			love.graphics.setColor(190/255, 150/255, 35/255, 0.6)
			love.graphics.setColor(10/255, 10/255, 15/255, 0.6)
		else
			love.graphics.setColor(30/255, 30/255, 35/255, 0.4)
		end
		love.graphics.print(points .. "$", 10, 13, 0, 1/2, 1/2)
		love.graphics.print("Best " .. highscore .. "$", 700, 13, 0, 1/2, 1/2)
		love.graphics.setColor(1, 1, 1)
	else
		love.graphics.setCanvas(self.canvas2)
		love.graphics.clear()

		love.graphics.draw(self.canvas, (self.scroll_x)%(love.graphics.getWidth()/4))
		love.graphics.draw(self.canvas, (self.scroll_x)%(love.graphics.getWidth()/4) - love.graphics.getWidth()/4)


		for i, v in ipairs(self.objects) do
			if not v.bubble then
		  	v:draw()
		  end
		end
		love.graphics.setCanvas()
		love.graphics.draw(self.canvas2, 0, 0, 0, 4, 4)

		for i, v in ipairs(self.objects) do
			if v.bubble then
				love.graphics.push()
				love.graphics.scale(4, 4)
		  	v:draw()
				love.graphics.pop()
		  end
		end

		local points = math.floor(GET("points")/10)
		local highscore = math.floor(GET("Highscore").score/10)
		if points == highscore then
			love.graphics.setColor(190/255, 150/255, 35/255, 0.6)
			love.graphics.setColor(10/255, 10/255, 15/255, 0.6)
		else
			love.graphics.setColor(30/255, 30/255, 35/255, 0.4)
		end
		--love.graphics.print(points .. "$", 10, 13, 0, 1, 1)
		love.graphics.print("Best " .. highscore .. "$", 700, 13, 0, 1/2, 1/2)
		love.graphics.setColor(1, 1, 1)
	end
end


function Scene_Game:update(dt)
	local driftspeed = GET("driftspeed")
	driftspeed = DRIFT(timer)
	local trashmod = GET("trashmod")
	
	if GET("isPlaying") then
		timer = timer + dt
		SET("driftspeed", driftspeed)
		if trashmod < 1 then
			TRASH_COUNTER = TRASH_COUNTER + (1-(trashmod)) * math.pow(driftspeed, 1.5) * dt * 7/1.5
		end
		FISH_COUNTER = FISH_COUNTER + (trashmod) * math.pow(driftspeed, 1.5) * dt * 2/5
		if trashmod > 0 then
			SET("trashmod", math.min(trashmod + 0.001*dt, 1))
		else
			trashmod = 0
		end

		local trash_size = driftspeed*5
		local a = math.floor(TRASH_COUNTER / trash_size)
		if a >= 1 then
			local x, y = 4 + love.graphics.getWidth()/4, math.random(32, love.graphics.getWidth()/4 - 156)
			table.insert(self.objects, require("gameobject.Trash"):new( x, y ))
			TRASH_COUNTER = TRASH_COUNTER % trash_size

		end


		local size = driftspeed
		if FISH_COUNTER > size then
			local x, y = 4 + love.graphics.getWidth()/4, math.random(32, love.graphics.getWidth()/4 - 156)
			table.insert(self.objects, require("gameobject.Fish"):new( x, y ))
			FISH_COUNTER = FISH_COUNTER - size
		end
	end

	------
	self.scroll_x = self.scroll_x - GET("driftspeed")*dt
	self.world:update(dt)
	for i, v in ipairs(GET("world_f")) do
		v.f(unpack(v.args))
	end
	SET("world_f", {})
	for i, gameObject in ipairs(self.objects) do
		gameObject:update(dt)
	end

	local gameObject = nil
	for i=#self.objects, 1, -1 do
		gameObject = self.objects[i]
		if gameObject.DEATH == true then
			if gameObject.isPlayer then
				self:reset()
				gameObject.DEATH = nil
			else
				gameObject.DEATH = -1
				gameObject.DESTROY = true --TODO make destroy contain the destroyer
				gameObject.callbacks:call("death", gameObject)
				table.remove(self.objects, i)
				gameObject:destruct()
			end
		end
	end

	


	if love.keyboard.isDown("k") then
		if not self.wasDown then
			--print("k")
		end
		self.wasDown = true
	else
		self.wasDown = false
	end

	if love.mouse.isDown(1) then
		local mx, my = love.mouse.getPosition()

	end


end


return Scene_Game
