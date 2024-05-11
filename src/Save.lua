local Prototype = require 'lua-additions.Prototype'
local Save = Prototype:clone("Save")

function Save:init()
	Prototype.init(self)

	self.filename = "savegame"
	info = love.filesystem.getInfo(self.filename)
	if info == nil then
		love.filesystem.newFile(self.filename)
	end


	return self
end

function Save:save()
	local binser = require 'lua-additions.binser'

	local t = {
		metal = GET("Hyperdrift").metal,
	}
	local savedata = binser.serialize(t)

	local success, message = love.filesystem.write(self.filename, savedata)
	return self
end

function Save:load()
	local binser = require 'lua-additions.binser'

	if not GET("Hyperdrift") then
		error("Hyperdrift was not initialized.")
	end

	local contents, size = love.filesystem.read(self.filename)

	savedata = nil
	if contents then
		savedata = binser.deserialize(contents)[1]
	end
	GET("Hyperdrift").metal = savedata and savedata.metal or 0
end

return Save
