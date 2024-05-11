local Object = require 'lua-additions.Object'
local Scene = Object:clone("Scene")

function Scene:init(manager)
  Object.init(self, manager)
  self.callbacks:declare("enable")
  self.callbacks:declare("disable")

  self.contents = {}

  self.enabled = false

  return self
end

function Scene:getContents()
  return self.contents
end

function Scene:enable()
  self.enabled = true
end

function Scene:disable()
  self.disable = true
end

function Scene:draw() end
function Scene:update(dt) end

function Scene:insert(obj)
  table.insert(self.contents, obj)
  obj.scene = self
end

function Scene:remove(obj)
  if type(obj) == "number" then
    if #self.contents >= obj then
      table.remove(self.contents, obj)
    end
    error()
  end
  for i = #self.contents, 1, -1 do
    if self.contents[i] == obj then
      table.remove(self.contents, i)
      return true
    end
  end
  return false
end

function Scene:removeAllDestroyed(obj)
  local gameObject = nil
  for i = #self.contents, 1, -1 do
    gameObject = self.contents[i]
    if gameObject.KILLED == true then
      gameObject.KILLED = -1
      gameObject.callbacks:call("killed", gameObject)
    end
    if gameObject.DEATH == true then
      gameObject.DEATH = -1
      gameObject.DESTROY = true --TODO make destroy contain the destroyer
      gameObject.callbacks:call("death", gameObject)
    end
    if gameObject.DESTROY then
      gameObject.callbacks:call("destroy", gameObject)
    end
    if gameObject.DESTROY then
      table.remove(self.contents, i)
    end
  end
end

return Scene
