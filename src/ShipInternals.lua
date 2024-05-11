local Inventory = require 'Inventory'
local ShipInternals = Inventory:clone("ShipInternals")

function ShipInternals:init()
  Inventory.init(self, 5, 6, false)

  self:loadShipSlots()

  self.callbacks:register("install", self.onInstall, self)
  self.callbacks:register("uninstall", self.onUninstall, self)

  return self
end

function ShipInternals:onInstall(thing, x, y)
  thing.callbacks:call("install")
end

function ShipInternals:onUninstall(thing)
  thing.callbacks:call("uninstall")
end

function ShipInternals:loadShipSlots()
  self:getSlot(2, 0).enabled = true
  self:getSlot(1, 1).enabled = true
  self:getSlot(2, 1).enabled = true
  self:getSlot(3, 1).enabled = true
  self:getSlot(1, 2).enabled = true
  self:getSlot(2, 2).enabled = true
  self:getSlot(3, 2).enabled = true
  self:getSlot(0, 3).enabled = true
  self:getSlot(1, 3).enabled = true
  self:getSlot(2, 3).enabled = true
  self:getSlot(3, 3).enabled = true
  self:getSlot(4, 3).enabled = true
  self:getSlot(1, 4).enabled = true
  self:getSlot(2, 4).enabled = true
  self:getSlot(3, 4).enabled = true
  self:getSlot(1, 5).enabled = true
  self:getSlot(3, 5).enabled = true
end


return ShipInternals