local Super = require 'gameobject.projectile.Projectile'
local Self = Super:clone("Bullet")

local IMG = love.graphics.newImage("assets/gfx/Mini Pixel Pack 3/Projectiles/Player_beam (2 x 9).png")


function Self:init(parent, x, y, r)
	Super.init(self, parent, x, y)
	self.r = r
	self.alliance = alliance
	self.speed = 300
	self.img = IMG
  self.w = 2
  self.h = 9

	self.jobs:insert(cron.after(10, self.die, self))

	self.body = love.physics.newBody(GET("World"), self.x, self.y)
	self.shape = love.physics.newRectangleShape(self.w, self.h)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	
	return self
end

function Self:update(dt)
	local dir_x, dir_y = math.sin(self.r), -math.cos(self.r)
	local norm = NORM(dir_x, dir_y)
	dir_x, dir_y = dir_x / norm, dir_y / norm

	self.x = self.x + dir_x * self.speed * dt
	self.y = self.y + dir_y * self.speed * dt


	self.jobs:update(dt)
end

function Self:draw()
	if self.quad then
		love.graphics.draw(self.img, self.quad, self.x, self.y, self.r, self.sx, self.sy, 8, 8)
	else
		love.graphics.draw(self.img, self.x, self.y, self.r, self.sx, self.sy, self.img:getWidth()/2, self.img:getHeight()/2)
	end
	self:drawHitbox()
end

return Self
