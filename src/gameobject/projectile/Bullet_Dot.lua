local Bullet_Dot = Bullet:clone("Bullet_Dot")

local IMG_BULLET_DOT = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Projectiles/Enemy_projectile (16 x 16).png")

function Bullet_Dot:init(parent, x, y, r)
	Bullet.init(self, parent, x, y, r)
	self.speed = 180

	self.img = IMG_BULLET_DOT
	self.quad = love.graphics.newQuad(2 * 16, 0, 16, 16, IMG_BULLET_DOT:getWidth(), IMG_BULLET_DOT:getHeight())

	self.w = 1 * 8
	self.h = 1 * 8

	self.canGiveGrace = true


	self.jobs:insert(cron.every(GET("Scenemanager"):getActiveScene().GRACE_REFRESH_RATE,
		function(self) self.canGiveGrace = true end, self))


	return self
end

function Bullet_Dot:update(dt)
	local dir_x, dir_y = math.sin(self.r), -math.cos(self.r)
	local norm = NORM(dir_x, dir_y)
	dir_x, dir_y = dir_x / norm, dir_y / norm

	self.x = self.x + dir_x * self.speed * dt
	self.y = self.y + dir_y * self.speed * dt


	self.jobs:update(dt)
end

return Bullet_Dot
