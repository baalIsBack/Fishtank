local Scene = require 'scene.Scene'
local Scene_Menue = Scene:clone("Scene_Menue")

local MUSIC_MAIN_MENUE = love.audio.newSource("assets/sfx/ACTION PACK 1 OGG/Mega-bot-pipes-forest.ogg", "stream")


function Scene_Menue:init(manager)
	Scene.init(self, manager)
	self.highscore = GET("Highscore")
	self.manager = manager
	self.music = MUSIC_MAIN_MENUE:clone()
	self.music:setVolume(0.1)
	self.music:setLooping(true)
	self.text_highscore = love.graphics.newText(FONT, "HIGHSCORE: " .. math.floor(self.highscore.score))
	self.text_play = love.graphics.newText(FONT, "Kill Vermin!")



	local hyperdrift = GET("Hyperdrift")
	self.hyperdrift = hyperdrift


	local starfield = GET("Starfield")
	self.starfield = starfield

	self.callbacks:register("enable", self.activate, self)
	self.callbacks:register("disable", self.deactivate, self)
	return self
end

function Scene_Menue:activate()
	if not GET("MUTE") then
		self.music:play()
	end
	self.text_highscore = love.graphics.newText(FONT, "HIGHSCORE: " .. math.floor(self.highscore.score))
end

function Scene_Menue:deactivate()
	self.music:stop()
end

function Scene_Menue:draw()
	self.starfield:draw()
	local mx, my = getMousePosition()
	if CHECK_COLLISION(mx, my, 1, 1, WINDOW_WIDTH / 2 - self.text_play:getWidth() / 2, WINDOW_HEIGHT / 2, self.text_play:getWidth(), self.text_play:getHeight()) then
		love.graphics.setColor(1, 0, 0)
	end
	love.graphics.draw(self.text_highscore, WINDOW_WIDTH / 2 - self.text_highscore:getWidth() / 2,
		WINDOW_HEIGHT / 2 - 40)
	love.graphics.draw(self.text_play, WINDOW_WIDTH / 2 - self.text_play:getWidth() / 2,
		WINDOW_HEIGHT / 2)
	--love.graphics.rectangle("line", WINDOW_WIDTH/2 - self.text_play:getWidth()/2, WINDOW_HEIGHT/2, self.text_play:getWidth(), self.text_play:getHeight())
	love.graphics.setColor(1, 1, 1)
end

function Scene_Menue:update(dt)
	self.starfield:update(dt)
	GET("Hyperdrift"):update(dt)
	local mx, my = getMousePosition()
	if CHECK_COLLISION(mx, my, 1, 1, WINDOW_WIDTH / 2 - self.text_play:getWidth() / 2, WINDOW_HEIGHT / 2, self.text_play:getWidth(), self.text_play:getHeight()) then
		if love.mouse.isDown(1) then
			GET("Scenemanager"):switch(Scene_Game:type())
		end
	end
end

return Scene_Menue
