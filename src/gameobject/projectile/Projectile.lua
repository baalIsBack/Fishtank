local Super = require 'gameobject.GameObject'
local Self = Super:clone("Projectile")


function Self:init(parent, x, y)
	Super.init(self, x, y)
	self.parent = parent

	self.fixture:setCategory(parent.fixture:getCategory(), FIXTURE_CATEGORY("projectile"))


	self.callbacks:register("collision", self.onCollision)
	return self
end

function Self:onCollision(gameObject)
	self:die()
end

return Self
