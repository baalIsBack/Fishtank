local Scenemanager = Prototype:clone("Scenemanager")



function Scenemanager:init()
	local Scene_Game = require 'scene.Scene_Game'
	local Scene_Menue = require 'scene.Scene_Menue'
	local Scene_UI1 = require 'scene.Scene_UI1'
	local Scene_UI2 = require 'scene.Scene_UI2'
	local Scene_UI3 = require 'scene.Scene_UI3'

	Prototype.init(self)

	self.scenes = {}
	self.scenes_ui = {}
	self.scenes_ui_current = 1
	self.ui_open = false

	local scene_game = Scene_Game:clone()
	self:register(Scene_Game:type(), scene_game) --TODO: fix: Must be initialized first
	SET("Scene_Game", scene_game)
	scene_game:init(self)

	local scene_menue = Scene_Menue:new(self)
	SET("Scene_Menue", scene_menue)
	self:register(Scene_Menue:type(), scene_menue)

	local scene_ui1 = Scene_UI1:new(self)
	SET("Scene_UI1", scene_ui1)
	self:register(Scene_UI1:type(), scene_ui1)

	local scene_ui2 = Scene_UI2:new(self)
	SET("Scene_UI2", scene_ui2)
	self:register(Scene_UI2:type(), scene_ui2)

	local scene_ui3 = Scene_UI3:new(self)
	SET("Scene_UI3", scene_ui3)
	self:register(Scene_UI3:type(), scene_ui3)

	self.activeSceneId = Scene_Game:type()
	self.scenes_prior = self.activeSceneId

	self:switch(Scene_Game:type())
	
	return self
end

function Scenemanager:register(scene_id, scene)
	self.scenes[scene_id] = scene
	if scene.isScene_UI then
		table.insert(self.scenes_ui, scene)
	end
end

function Scenemanager:draw()
	self:getActiveScene():draw()
end

function Scenemanager:update(dt)
	if love.keyboard.isDown("f") then
		if not self.wasDown then
			self:toggleUI()
		end
		self.wasDown = true
	else
		self.wasDown = false
	end
	self:getActiveScene():update(dt)
end

function Scenemanager:nextUI()
	self.scenes_ui_current = ((self.scenes_ui_current-1+1)%#self.scenes_ui) + 1
	self:switch(self.scenes_ui[self.scenes_ui_current]:type(), true)
end

function Scenemanager:previousUI()
	self.scenes_ui_current = ((self.scenes_ui_current-1-1)%#self.scenes_ui) + 1
	self:switch(self.scenes_ui[self.scenes_ui_current]:type(), true)
end

function Scenemanager:openUI()
	self.scenes_ui_current = ((self.scenes_ui_current-1)%#self.scenes_ui) + 1
	self:switch(self.scenes_ui[self.scenes_ui_current]:type())
	self.ui_open = true
end

function Scenemanager:closeUI()
	self:switch(self.scenes_prior)
	self.ui_open = false
end

function Scenemanager:toggleUI()
	if self.ui_open then
		self:closeUI()
	else
		self:openUI()
	end
end

function Scenemanager:getActiveScene()
	local x = self.scenes[self.activeSceneId]
	assert(x, "No Active Scene for Scene!")
	return x
end

function Scenemanager:get(scene_id)
	local x = self.scenes[scene_id]
	assert(x, "No Scene found with id: " .. scene_id)
	return x
end

function Scenemanager:switch(scene_id, retainPriorScene)
	if not scene_id then
		scene_id = self.activeSceneId
	end
	self:getActiveScene().callbacks:call("disable", self:getActiveScene())
	if not retainPriorScene then
		self.scenes_prior = self.activeSceneId
	end
	self.activeSceneId = scene_id
	self:getActiveScene().callbacks:call("enable", self:getActiveScene())
end



return Scenemanager
