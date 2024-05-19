local Super = require 'gameobject.GameObject'
local Self = Super:clone("CreditBubble")

Self.shape = love.physics.newCircleShape(3)
Self.sound = love.audio.newSource("assets/sfx/bubblepop.wav", "static")
Self.sound:setVolume(0.2)

Self.img = love.graphics.newImage("assets/gfx/bubble1.png")
function Self:init(x, y)
	Super.init(self, x, y)


	self.bubble = true
	
	self.body:setMass(100)

	self.body:applyLinearImpulse(-GET("driftspeed") * 100, 0)
	local accuracy = 1000
	local anglestrength = 0.3
	self.body:setAngle(math.pi)
	self.body:setAngularDamping(1000)
	--self.body:setFixedRotation(true)
	self.body:setLinearDamping(0.6)
	self.callbacks:register("collision", self.onCollision)

	self.offset = math.random(0, 1000)

	self.direction = "left"
	self.counter = math.random(0, 100)

	return self
end

function Self:onCollision(gameObject)
	if gameObject.killsFish then
		self:die()
		
		self.sound:play()

		table.insert(GET("world_f"), {f=function()
			local scene = GET("SCENE")
			table.insert(scene.objects, require("gameobject.CreditsBubble"):new(150, 150, "PROGRAMMING BY \nMATHIAS A. SCHULTE"))
			table.insert(scene.objects, require("gameobject.CreditsBubble"):new(80, 72, "SPRITES BY \nHANNAH L. OZCIFTCI"))
			table.insert(scene.objects, require("gameobject.CreditsBubble"):new(190, 50, "ENGINE: \nLOVE2D"))
			table.insert(scene.objects, require("gameobject.CreditsBubble"):new(258, 130, "TILESET FROM \nCHASERSGAMING"))
			table.insert(scene.objects, require("gameobject.CreditsBubble"):new(270, 60, "SOUNDTOOL: \nCHIPTONE BY SFBGAMES"))
			table.insert(scene.objects, require("gameobject.CreditsBubble"):new(125, 81, "MUSIC FROM \nMIXKIT"))

		 end,args={}})
	end
end



function Self:update(dt)
	self.jobs:update(dt)
	self.counter = self.counter + dt

	if GET("isPlaying") then
		self:die()
	end


end

function Self:draw()
	--love.graphics.draw(self.img, math.floor(self.body:getX()), math.floor(self.body:getY()), math.pi-self.body:getAngle(), 1, 1, 4, 4)
	--love.graphics.setColor(16/255, 115/255, 235/255, 1)
	love.graphics.setFont(FONT2)
	local x, y = (self.body:getX()), (self.body:getY()) + math.sin(self.counter)*3
	--love.graphics.circle("line", x, y, 10, 44)
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("CREDITS", (x-16), (y-10), 0, 1/4, 1/4)

	love.graphics.draw(self.img, x-4, y-4)

	love.graphics.setFont(FONT)
end

return Self
