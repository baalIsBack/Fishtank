local GameObject = require 'gameobject.GameObject'
local PlanetGenerator = GameObject:clone("PlanetGenerator")

local mesh = require("QuadMesh")

function PlanetGenerator:init(x, y, kind)
	GameObject.init(self, x, y)

	self.fixture:getBody():setType("kinematic")

	local stars = {
		"love2d-pixel-planets.components.planets.asteroids.asteroid_collection",    --broken
		"love2d-pixel-planets.components.planets.black_hole.black_hole_collection", --broken
		"love2d-pixel-planets.components.planets.dry_terran.dry_terran_collection",
		"love2d-pixel-planets.components.planets.galaxy.galaxy_collection",         --broken
		"love2d-pixel-planets.components.planets.gas_giant.gas_giant_collection",
		"love2d-pixel-planets.components.planets.gas_planet.gas_planet_collection",
		"love2d-pixel-planets.components.planets.ice_world.ice_world_collection",
		"love2d-pixel-planets.components.planets.land_masses.land_masses_collection",
		"love2d-pixel-planets.components.planets.lava_world.lava_world_collection",       --turning rate wrong?
		"love2d-pixel-planets.components.planets.no_atmosphere.no_atmosphere_collection", --turning rate wrong?
		"love2d-pixel-planets.components.planets.rivers.rivers_collection",
		"love2d-pixel-planets.components.planets.star.star_collection",                   --wrong?
	}
	self.star = require(stars[kind or 11])
	--self.star = require("love2d-pixel-planets.components.planets.land_masses.land_masses_collection")



	return self
end

function PlanetGenerator:update(dt)
	table.sort(self.star, function(a, b) return a.position.z < b.position.z end)

	for i, collection in ipairs(self.star) do
		local material = collection.component[2]

		material.generic[2] = love.timer.getTime()
		material.shader:send("generic", material.generic)

		if material.transform then
			--material.transform[2] = 200--love.timer.getTime()*10
			material.shader:send("transform", material.transform)
		end
	end
end

--local s = love.graphics.newShader 'planets/Star/Star.shader'

function PlanetGenerator:draw()
	for i, collection in ipairs(self.star) do
		love.graphics.setShader(collection.component[2].shader)
		love.graphics.draw(collection.component[1], self.body:getX() + collection.position.x, self.body:getY() + collection.position.y, 0,
			collection.scale3.x, collection.scale3.y)
	end

	--love.graphics.setShader(s)
	--love.graphics.draw(mesh, 100, 100, 0, 10, 10)

	love.graphics.setShader()
end

return PlanetGenerator
