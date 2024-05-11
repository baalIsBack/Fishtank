local Object = require 'lua-additions.Object'
local Inventory = Object:clone("Inventory")

function Slot(enabled, x, y)
	return { enabled = enabled, x = x, y = y, content = nil, }
end

function Inventory:init(w, h, defaultEnabled)
	Object.init(self)
	self.callbacks:declare("install")
	self.callbacks:declare("uninstall")

	self.w = w
	self.h = h

	self.inventory = {}
	for x = 0, self.w - 1 do
		self.inventory[x] = {}
		for y = 0, self.h - 1 do
			self.inventory[x][y] = Slot(defaultEnabled or false, x, y)
		end
	end

	return self
end

function Inventory:swapWithHand(x, y)
	if self:getContent(x, y) == nil then
		if GET("hand") ~= nil then
			if self:insert(GET("hand"), x, y) then
				SET("hand", nil)
			end
		end
	else
		if GET("hand") == nil then
			SET("hand", self:getContent(x, y))
			self:remove(x, y)
		end
	end
end

function Inventory:getWidth()
	return self.w
end

function Inventory:getHeight()
	return self.h
end

function Inventory:getInventory()
	return self.inventory
end

function Inventory:getSlot(x, y)
	return self.inventory[x][y]
end

function Inventory:getContent(x, y)
	return self:getSlot(x, y).content
end

function Inventory:getEnabledSlots()
	local slots = {}
	for x = 0, self.w - 1 do
		for y = 0, self.h - 1 do
			if self.inventory[x][y].enabled then
				table.insert(slots, self.inventory[x][y])
			end
		end
	end
	return slots
end

function Inventory:isValid(x, y)
	return not (x < 0 or x > self.w - 1 or y < 0 or y > self.h - 1) -- and self.inventory[x] and self.inventory[x][y]
end

function Inventory:isEnabled(x, y)
	return self:isValid(x, y) and self.inventory[x][y].enabled -- and self.inventory[x] and self.inventory[x][y]
end

function Inventory:canFitInInventoryBounds(thing, x, y)
	return not (x + (thing.w - 1) > self.w - 1 or y + (thing.h - 1) > self.h - 1)
end

function Inventory:isFree(x, y)
	return self:isValid(x, y) and self:getContent(x, y) == nil
end

function Inventory:isRegionEnabled(x, y, w, h)
	for i = 0, w - 1 do
		for j = 0, h - 1 do
			if not self:isEnabled(x + i, y + j) then
				return false
			end
		end
	end
	return true
end

function Inventory:isRegionFree(x, y, w, h)
	for i = 0, w - 1 do
		for j = 0, h - 1 do
			if not self:isFree(x + i, y + j) then
				return false
			end
		end
	end
	return true
end

function Inventory:canInsert(thing, x, y)
	return self:canFitInInventoryBounds(thing, x, y) and self:isRegionFree(x, y, thing.w, thing.h) and
			self:isRegionEnabled(x, y, thing.w, thing.h)
end

function Inventory:findSuitableSpot(thing)
	for y = 0, self.h - 1 do
		for x = 0, self.w - 1 do
			if self:canInsert(thing, x, y) then
				return x, y
			end
		end
	end
	return nil, nil
end

function Inventory:insert(thing, x, y)
	local x, y = x, y
	if x == nil and y == nil then
		x, y = self:findSuitableSpot(thing)
	end
	if not x or not y or not self:canInsert(thing, x, y) then
		return false
	end

	for i = 0, thing.w - 1 do
		for j = 0, thing.h - 1 do
			self.inventory[x + i][y + j].content = thing
		end
	end
	self.callbacks:call("install", thing, x, y) --call to trigger
	return true
end

function Inventory:remove(thing_or_x, y)
	local thing = nil
	if type(thing_or_x) == "number" then
		thing = self:getSlot(thing_or_x, y).content
	else
		thing = thing_or_x
	end
	local atleastOnce = false
	for x = 0, self.w - 1, 1 do
		for y = 0, self.h - 1, 1 do
			if self.inventory[x][y].content == thing then
				self.inventory[x][y].content = nil
				atleastOnce = true
			end
		end
	end
	if atleastOnce then
		self.callbacks:call("uninstall", thing, thing_or_x, y) --call to trigger
	end
end

function Inventory:fillWith(thing)
	local x, y = self:findSuitableSpot(thing)
	while x ~= nil do
		self:insert(thing, x, y)
		x, y = self:findSuitableSpot(thing)
	end
end

return Inventory
