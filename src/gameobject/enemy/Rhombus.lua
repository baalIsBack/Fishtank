local Super = require 'gameobject.enemy.Enemy'
local Self = Super:clone("Rhombus")

local IMG = love.graphics.newImage("assets/gfx/retro-shoot-em-up/Rhombus.png")

function Self:init(x, y)
	Super.init(self, x, y)
	self.img = IMG
	self.bountyModifier = 2

	self.animation = Animation:new(8, {
		love.graphics.newQuad(0 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight())
	}):pause()

	--self.jobs:insert(self.animation)
	--self.jobs:insert(cron.after(8, self.die, self))
	self.jobs:insert(cron.every(1, self.targetPlayer, self))

	self.callbacks:register("death", function() print("DEAD") end)

	self:targetPlayer()

	return self
end


return Self
