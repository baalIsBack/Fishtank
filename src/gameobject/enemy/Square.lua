local Super = require 'gameobject.enemy.Enemy'
local Self = Super:clone("Rectangle")

local IMG = love.graphics.newImage("assets/gfx/retro-shoot-em-up/Square.png")

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
	--self.jobs:insert(cron.after(8, self.die, self))
	self.jobs:insert(cron.every(1, self.targetPlayer, self))

	self:targetPlayer()

	return self
end

function Self:targetPlayer()
	local player = GET("Scenemanager"):getActiveScene().player
	self.dx = player.x - self.x
	self.dy = player.y - self.y
end

function Self:update(dt)
	self.jobs:update(dt)


	
	if math.abs(self.dx) > math.abs(self.dy) then
		self.x = self.x + 100*dt*(self.dx/math.abs(self.dx))
	else
		self.y = self.y + 100*dt*(self.dy/math.abs(self.dy))
	end


	-- self:collisionResolution()
end

return Self
