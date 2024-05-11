local Scene = require 'scene.Scene'
local Scene_UI = Scene:clone("Scene_UI")

local UIElement = require 'ui.atom.UIElement'

function Scene_UI:init(manager)
	Scene.init(self, manager)

	self.contents = {}

	self.page = 0
	self.maxPage = 0

	self.hud = GET("Hud")

	self:insertDefault(0)

	--self:insert(0, self.hud)
	self.map = require("ui.UIMap"):new(-3, 2)
	self:insert(0, self.map)


	self:insertDefault(1)
	self:insert(1, require("ui.UICargo"):new(-3, -1))


	self:insertDefault(2)
	self:insert(2, require("ui.UIShipInternals"):new(-3, 0))

	self.wasDown = false

	self.callbacks:register("enable", self.activate, self)
	self.callbacks:register("disable", self.deactivate, self)
	return self
end

function Scene_UI:insertDefault(id)
	self:insert(id, require("ui.UIBackground"):new())
	self:insert(id,
		require("ui.atom.UIButton"):new("R", UIElement.RIGHT - 1, UIElement.TOP + 1, 1, 1,
			function(button)
				self.page = (self.page + 1) % (self.maxPage + 1)
			end))
	self:insert(id,
		require("ui.atom.UIButton"):new("L", UIElement.LEFT + 1, UIElement.TOP + 1, 1, 1,
			function(button)
				self.page = (self.page - 1) % (self.maxPage + 1)
			end))
end

function Scene_UI:insert(id, content)
	if not self.contents[id] then
		self.contents[id] = {}
		self.maxPage = math.max(self.maxPage, id)
	end
	table.insert(self.contents[id], content)
end

function Scene_UI:getContents(id)
	local id = id or self.page
	if not self.contents[id] then
		return {}
	end
	return self.contents[id]
end

function Scene_UI:activate()
	GET("Map"):resetScroll()
	GET("Map"):generate()
	--self.map:renderStars()
end

function Scene_UI:deactivate()
	GET("Map"):resetScroll()
	GET("Map"):generate()
	--self.map:renderStars()
end

function Scene_UI:draw()
	if not self.enabled then
		return
	end
	love.graphics.push("all")
	love.graphics.origin()
	ALPHA = 1
	for i, uie in ipairs(self:getContents()) do
		if uie == GET("Hud") then
			local backgroundState = uie.hud_text:getBackground()
			uie.hud_text:setBackground(true)
			uie:draw()
			uie.hud_text:setBackground(backgroundState)
		else
			uie:draw()
		end
	end
	love.graphics.pop()
end

function Scene_UI:update(dt)
	if love.keyboard.isDown("f") then
		if not self.wasDown then
			self.enabled = not self.enabled
			if self.enabled then
				self.callbacks:call("enable")
			else
				self.callbacks:call("disable")
			end
		end
		self.wasDown = true
	else
		self.wasDown = false
	end
	if not self.enabled then
		return
	end
	for i, uie in ipairs(self:getContents()) do
		uie:update(dt)
	end
end

return Scene_UI
