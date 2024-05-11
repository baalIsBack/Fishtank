local Scene = require 'scene.Scene'
local Scene_Game = Scene:clone("Scene_Game")

local MUSIC_MAIN_GAME = love.audio.newSource("assets/sfx/ACTION PACK 1 OGG/Magic Fx 7.ogg", "stream")

function Scene_Game:init(manager)
	Scene.init(self, manager)

	self.world = GET("World")

	self.highscore = GET("Highscore")

	self.manager = manager
	self.music = MUSIC_MAIN_GAME:clone()
	self.music:setLooping(true)
	self.music:setVolume(0.1)


	self.contents = {}
	self:reset()



	local ui = require("scene.Scene_UI"):new()
	self.ui = ui
	self.ui.enabled = true


	self.shake = 0
	self.GRACE_REFRESH_RATE = 0.15

	--self.callbacks:register("enable", self.reset, self)
	self.callbacks:register("enable", self.enable, self)
	self.callbacks:register("disable", self.disable, self)
	self.callbacks:register("disable", self.onDisable, self)

	

	return self
end

function Scene_Game:reset()
	local Player = require 'gameobject.Player'

	self.score = 0
	self.contents = {}




	require("Statsheet")

	local hyperdrift = GET("Hyperdrift")
	self:insert(hyperdrift)
	if hyperdrift then
		hyperdrift:reset()
	end


	local starfield = GET("Starfield")
	self:insert(starfield)

	--self:insert(Planet:new())

	self.player = Player:new(WINDOW_WIDTH / 2 - 8, WINDOW_HEIGHT * 0.95)
	self:insert(self.player)

	self.hud = GET("Hud")

	if not GET("MUTE") then
		self.music:play()
	end
end

function Scene_Game:scheduleReset()
	self.reset_scheduled = true
end

function Scene_Game:onDisable()
	self.score = self.score + GET("Hyperdrift"):getCombo() * GET("Hyperdrift"):getIntensity()
	--  require("Highscore"):set(self.score, true)
	self.music:stop()
end

function Scene_Game:draw()
	self.callbacks:call("predraw", self)
	for i, gameObject in ipairs(self.contents) do
		gameObject:draw()
	end
	self.callbacks:call("postdraw", self)

	love.graphics.origin()
	if GET("Hud") then
		local backgroundState = GET("Hud").hud_text:getBackground()
		GET("Hud").hud_text:setBackground(false)
		self.hud:draw()
		GET("Hud").hud_text:setBackground(backgroundState)
	end

	self.ui:draw()
end

function Scene_Game:update(dt)
	self.world:update(dt)
	print(self.world:getBodyCount())
	self.ui:update(dt)
	if self.enabled then
		self.jobs:update(dt)
		for i, gameObject in ipairs(self.contents) do
			gameObject:update(dt)
		end
		local gameObject = nil
		for i = #self.contents, 1, -1 do
			gameObject = self.contents[i]
			if gameObject.KILLED == true then
				gameObject.KILLED = -1
				gameObject.callbacks:call("killed", gameObject)
			end
			if gameObject.DEATH == true then
				gameObject.DEATH = -1
				gameObject.DESTROY = true --TODO make destroy contain the destroyer
				gameObject.callbacks:call("death", gameObject)
			end
			if gameObject.DESTROY then
				gameObject.callbacks:call("destroy", gameObject)
			end
		end
		for i = #self.contents, 1, -1 do
			gameObject = self.contents[i]
			if gameObject.DESTROY then
				gameObject:destruct()
				assert(gameObject == self.contents[i], "Wrong object got deleted. This has to be investigated imm.!")
				table.remove(self.contents, i)
			end
		end
	end
	self.hud:update(dt)
	if self.reset_scheduled then
		self.reset_scheduled = false
		self:reset()
	end
end


return Scene_Game
