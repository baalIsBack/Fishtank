if arg[2] == "debug" then
	require("lldebugger").start()
end

--TODO: https://love2d.org/forums/viewtopic.php?t=94623
love.graphics.setDefaultFilter("nearest", "nearest")

Global = require 'lua-additions.Global'
function GET(id)
	return Global:get(id)
end

function SET(id, val)
	return Global:set(id, val)
end

SET("MUTE", true)
require 'extension'


function spairs(t, order)
	-- collect the keys
	local keys = {}
	for k in pairs(t) do keys[#keys + 1] = k end

	-- if order function given, sort by it by passing the table and keys a, b,
	-- otherwise just sort the keys
	if order then
		table.sort(keys, function(a, b) return order(t, a, b) end)
	else
		table.sort(keys)
	end

	-- return the iterator function
	local i = 0
	return function()
		i = i + 1
		if keys[i] then
			return keys[i], t[keys[i]]
		end
	end
end

function show(t)
	print("---------------------")
	print("----Showing-table----")
	print("---------------------")
	for i, v in pairs(t) do
		print("" .. i .. ":", v)
	end
end

local scenemanager

--FONT = love.graphics.newFont("assets/font/Weiholmir Standard/Weiholmir_regular.ttf", 16)

--FONT:setFilter("nearest", "nearest")

--[[
Prototype = require 'lua-additions.Prototype'
cron = require 'lua-additions.cron'
Jobs = require 'lua-additions.Jobs'
Callbackmanager = require 'lua-additions.Callbackmanager'
GameObject = require 'gameobject.GameObject'
Explosion = require 'gameobject.Explosion'
Gun = require 'gameobject.Gun'
Starfield = require 'Starfield'
Boosters = require 'gameobject.Boosters'
Player = require 'gameobject.Player'
Enemy = require 'gameobject.enemy.Enemy'
Alan = require 'gameobject.enemy.Alan'
Lips = require 'gameobject.enemy.Lips'
BonBon = require 'gameobject.enemy.BonBon'
Powerup_Shield = require 'gameobject.Powerup_Shield'
Animation = require 'lua-additions.Animation'
Grace = require 'gameobject.Grace'
Planet = require 'gameobject.Planet'
GreenCount = require 'gameobject.enemy.GreenCount'
BlueThing = require 'gameobject.enemy.BlueThing'
Clapper = require 'gameobject.enemy.Clapper'
GreenCount = require 'gameobject.enemy.GreenCount'
Octo = require 'gameobject.enemy.Octo'
Parasite = require 'gameobject.enemy.Parasite'
RedDude = require 'gameobject.enemy.RedDude'
Robo = require 'gameobject.enemy.Robo'
YellaFella = require 'gameobject.enemy.YellaFella'
Scene_Game = require 'scene.Scene_Game'
Scene_Menue = require 'scene.Scene_Menue'
Hyperdrift = require 'Hyperdrift']]

Prototype = require 'lua-additions.Prototype'
cron = require 'lua-additions.cron'
Jobs = require 'lua-additions.Jobs'
Callbackmanager = require 'lua-additions.Callbackmanager'
GameObject = require 'gameobject.GameObject'
Scenemanager = require 'scene.Scenemanager'

timer = 0
function DRIFT(x)
	return math.log(x/5+1)*30
end

local FIXTURE_CATEGORYS = {}
function FIXTURE_CATEGORY(str)
	local id = -1
	for i, v in ipairs(FIXTURE_CATEGORYS) do
		if v == str then
			id = i
			break
		end
	end
	if id == -1 then
		table.insert(FIXTURE_CATEGORYS, str)
		id = #FIXTURE_CATEGORYS
	end

	return id
end

local function beginContact(a, b, coll)
end

local function endContact(a, b, coll)
	
end

local function preSolve(a, b, coll)
	
	local aGameObject = a:getUserData()
	local bGameObject = b:getUserData()
	if aGameObject == GET("player") and bGameObject.isFish then
		coll:setEnabled(false)
		aGameObject.callbacks:call("collision", aGameObject, bGameObject)
		bGameObject.callbacks:call("collision", bGameObject, aGameObject)
	elseif bGameObject == GET("player") and aGameObject.isFish then
		coll:setEnabled(false)
		aGameObject.callbacks:call("collision", aGameObject, bGameObject)
		bGameObject.callbacks:call("collision", bGameObject, aGameObject)
	else
		return
	end

end
SET("world_f", {})
local function postSolve(a, b, coll, normal_impulse1, tangent_impulse1, normal_impulse2, tangent_impulse2)
	local aGameObject = a:getUserData()
	local bGameObject = b:getUserData()
	aGameObject.callbacks:call("collision", aGameObject, bGameObject)
	bGameObject.callbacks:call("collision", bGameObject, aGameObject)
--	print(normal_impulse1, tangent_impulse1, normal_impulse2, tangent_impulse2)
	
end

function resetWorld()
	for i, v in ipairs(GET("World"):getBodies( )) do
		if not v:getUserData() or v:getUserData().isPlayer then

		else
			v:destroy()
		end
	end
end

function love.load()
	love.graphics.setBackgroundColor(0, 0, 16 / 255)
	--love.graphics.setFont(FONT)
	--local UI_FONT = love.graphics.newFont("assets/font/spacecargo.ttf", math.floor(2 * 5))


	SET("focus", true)
	--SET("BLOCK_SIZE_W", 12 * 2)
	--SET("BLOCK_SIZE_H", 12 * 2)
	--SET("PIXEL_SIZE_W", (UI_FONT:getWidth("a")) / 4)
	--SET("PIXEL_SIZE_H", (UI_FONT:getHeight()) / 5)

	math.randomseed(os.time())

	world = love.physics.newWorld( 0, 0, true )
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	SET("World", world)

	--SET(require("Statsheet"):new())
	--SET(require("Save"):new())
	SET(require("Highscore"):new())
	---SET(require("Starfield"):new())
	--SET(require("Hyperdrift"):new())
	--SET(require("Conductor"):new())
	--SET(require("ShipInternals"):new())
	--SET(require("Map"):new())
	--SET("Cargo", require("Inventory"):new(6, 6, true))
	--SET("Hud", require("ui.Hud"):new())

	scenemanager = Scenemanager:clone()
	SET(scenemanager)
	scenemanager:init()

	local d = require("Debug"):new()
	SET(d)

	--  A = require("PlanetGenerator"):new(300, 300)
end

function love.update(dt)
	
	--  A:update(dt)
	--GET(Keyboard:type()):update(dt)

	if not love.window.hasFocus() then
		love.timer.sleep(0.2)
	end
	if dt > 0.2 then
		dt = dt - 0.2
	end
	scenemanager:update(dt)

	GET("Debug"):update(dt)
end

WINDOW_WIDTH, WINDOW_HEIGHT = 320, 360 --314
CANVAS_X, CANVAS_Y = 160, 0

function getMousePosition()
	local mx, my = love.mouse.getPosition()
	local x, y = (mx - CANVAS_X), (my - CANVAS_Y)
	return x, y
end

function love.draw()
	--love.graphics.setBackgroundColor(0.4, 0.6, 0.4)
	scenemanager:draw()


	GET("Debug"):draw()
end

function love.quit()
	--GET("Save"):save()
	GET("Highscore"):write()


	return false
end

function love.keypressed(key)
	GET("Debug"):keypressed(key)
end
