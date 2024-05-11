local Object = require 'lua-additions.Object'
local Debug = Object:clone("Debug")


function Debug:init()
	Object.init(self)

	self:reset()

	return self
end

function Debug:reset()
	self.showHitboxes = false
	self.godMode = false
end

function Debug:draw()

end

function Debug:update(dt)
end

function Debug:keypressed(key)
	if key == "f1" then
		self:toggleHitboxes()
	end
	if key == "f2" then
		self:togglGodmode()
	end
	if key == "f3" then
		self:spawnMetal()
	end
end

function Debug:toggleHitboxes()
	self.showHitboxes = not self.showHitboxes
end

function Debug:toggleGodmode()
	self.godMode = not self.godMode
end

function Debug:spawnMetal()
	local Metal = require 'gameobject.loot.Metal'
	local hyperdrift = GET("Hyperdrift")
	local scene_game = GET("Scenemanager"):get(Scene_Game:type())
	local x, y = hyperdrift:suitableSpawnLocation()
	scene_game:insert(Metal:new(x, y))
end

return Debug
