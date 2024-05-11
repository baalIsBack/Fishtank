local Enemy = require 'gameobject.enemy.Enemy'
local YellaFella = Enemy:clone("YellaFella")

local IMG_ENEMY_YELLAFELLA = love.graphics.newImage("assets/gfx/pico8_invaders/YellaFella.png")

function YellaFella:init(x, y)
	Enemy.init(self, x, y)
	self.img = IMG_ENEMY_YELLAFELLA
	self.speed = 100
	self.bountyModifier = 2

	self.animation = Animation:new(8, {
		love.graphics.newQuad(0 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight()),
		love.graphics.newQuad(1 * self.spritesize, 0 * self.spritesize,
			self.spritesize, self.spritesize,
			self.img:getWidth(), self.img:getHeight())
	})

	self.jobs:insert(self.animation)
	self.jobs:insert(cron.after(8, self.die, self))
	return self
end

function YellaFella:update(dt)
	self.jobs:update(dt)

	self:drift(dt)
	--self:drift(dt)
	local angle = ANGLE(self.x, self.y, GET("Scenemanager"):getActiveScene().player.x,
		GET("Scenemanager"):getActiveScene().player.y)
	local subangle = math.pi / 3
	local tractorSpeed = 300
	local dist = 300
	if DIST(self.x, self.y, GET("Scenemanager"):getActiveScene().player.x, GET("Scenemanager"):getActiveScene().player.y) < dist and angle > math.pi / 2 + subangle and angle < 3 * math.pi / 2 - subangle then
		local dir_x, dir_y = math.sin(angle), -math.cos(angle)
		local norm = NORM(dir_x, dir_y)
		dir_x, dir_y = dir_x / norm, dir_y / norm

		GET("Scenemanager"):getActiveScene().player.x = GET("Scenemanager"):getActiveScene().player.x -
				dir_x * tractorSpeed * dt
		--GET("Scenemanager"):getActiveScene().player.y = GET("Scenemanager"):getActiveScene().player.y - dir_y * tractorSpeed * dt
	end

	-- self:collisionResolution()
end

return YellaFella
