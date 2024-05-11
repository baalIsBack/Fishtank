local function NEW_RECURSIVE_CALL(t, mt, ...)
	if mt == nil then
		return
	end
	local f_load = rawSET(mt, "load")
	if f_load then
		NEW_RECURSIVE_CALL(t, getmetatable(mt), ...)
		f_load(t, ...)
	end
end

local SINGLETONS = {}
function NEW(...)
	if mt.isSingleton and SINGLETONS[mt] then
		return SINGLETONS[mt]
	end
	local self = {}
	mt.__index = mt
	setmetatable(self, mt)

	NEW_RECURSIVE_CALL(self, mt, ...)

	if mt.isSingleton then
		SINGLETONS[mt] = self
		return SINGLETONS[mt]
	end
	return self
end

function calcInput()
	local dir_x = 0
	local dir_y = 0
	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		dir_x = dir_x - 1
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		dir_x = dir_x + 1
	end
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		dir_y = dir_y - 1
	end
	if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		dir_y = dir_y + 1
	end
	return dir_x, dir_y
end

function SIGN(x)
	if x < 0 then return -1 end
	return 1
end

function ROUND(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function NORM(a, b)
	local x = math.sqrt(a * a + b * b)
	if x == 0 then
		return 1
	end
	return x
end

function CHECK_COLLISION(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 < x2 + w2 and
			x2 < x1 + w1 and
			y1 < y2 + h2 and
			y2 < y1 + h1
end

function ID() end

function FOREACH(t, f, ...)
	for i, v in ipairs(t) do
		f(v, i, ...)
	end
end

function DIST(x1, y1, x2, y2)
	return NORM(x2 - x1, y2 - y1)
end

function ANGLE(x1, y1, x2, y2)
	return math.atan2(y2 - y1, x2 - x1) + math.pi / 2
end

function POLAR2CARTESIAN(rotation, length)
	return length * math.cos(rotation), length * -math.sin(rotation)
end

---Returns a random element from the pool, where each element has a weight ascribed.
---@param pool table has to be {{number, any}}
---@return any
function WEIGHTED_RANDOM(pool)
	local poolsize = 0
	for k, v in ipairs(pool) do
		poolsize = poolsize + v[1]
	end
	local selection = math.random(1, poolsize)
	for k, v in ipairs(pool) do
		selection = selection - v[1]
		if (selection <= 0) then
			return v[2]
		end
	end
end

---Create a hash from a string using djb2
---@param String to hash
---@return hash
function HASH(str)
	local hash = 5381
	for i = 1, #str do
		local char = str:byte(i)
		hash = ((hash * 33) + char) % 2^32
	end
	return hash
end

function SMALLER(a, b)
	if math.abs(a) < math.abs(b) then
		return a
	else
		return b
	end
end

function BIGGER(a, b)
	if math.abs(a) > math.abs(b) then
		return a
	else
		return b
	end
end

function applyDirectionalForce(body, force)
	local angle = body:getAngle()
	body:applyForce( force * math.cos( angle ), force * -math.sin(angle))
end

function applyDirectionalImpulse(body, impulse)
	local angle = body:getAngle()
	body:applyLinearImpulse( impulse * math.cos( angle ), impulse * -math.sin(angle))
end