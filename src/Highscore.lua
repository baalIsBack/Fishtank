local Protoype = require 'lua-additions.Prototype'
local Highscore = Prototype:clone("Highscore")

function Highscore:init()
  Prototype.init(self)

  

  self.filename = "highscore"
  self.score = 0
  info = love.filesystem.getInfo( self.filename )
  if info == nil then
    love.filesystem.newFile( self.filename )
  end

  self:read()


  return self
end

function Highscore:read()
  local contents, size = love.filesystem.read(self.filename)
  self.score = math.floor(contents or 0)--tonumber
  return self.score
end

function Highscore:set(val, shouldWrite)
  self.score = self.score
  if val <= self.score then
    return self.score
  end
  self.score = val
  if not shouldWrite then
    return self.score
  end
  self:write()
end

function Highscore:write()
  local success, message = love.filesystem.write(self.filename, "" .. self.score)
end


return Highscore
