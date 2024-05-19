local Scenemanager = Prototype:clone("Scenemanager")



function Scenemanager:init()
	local Scene_Game = require 'scene.Scene_Game'

	Prototype.init(self)

	self.scenes = {}
	self.scenes_ui = {}
	self.scenes_ui_current = 1
	self.ui_open = false

	local scene_game = Scene_Game:clone()
	self:register(Scene_Game:type(), scene_game) --TODO: fix: Must be initialized first
	SET("Scene_Game", scene_game)
	scene_game:init(self)

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
	if false and love.keyboard.isDown("f") then
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
