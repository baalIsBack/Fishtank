local Super = require 'gameobject.enemy.Enemy'
local Self = Super:clone("Piercer")

local IMG = love.graphics.newImage("assets/gfx/retro-shoot-em-up/Piercer.png")

function Self:init(x, y)
	Super.init(self, x, y)
	self.img = IMG
	self.speed = 75
	self.bountyModifier = 2

	self.animation = Animation:new(8, {
		love.graphics.newQuad(0 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight())
	}):pause()

	--self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(8, self.die, self))

	self:targetFront(10000)
	applyDirectionalImpulse(self.body, 100)


	return self
end



return Self
