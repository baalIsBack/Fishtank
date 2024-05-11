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

FONT = love.graphics.newFont("assets/font/Weiholmir Standard/Weiholmir_regular.ttf", 16)

FONT:setFilter("nearest", "nearest")

Prototype = require 'lua-additions.Prototype'
cron = require 'lua-additions.cron'
Jobs = require 'lua-additions.Jobs'
Callbackmanager = require 'lua-additions.Callbackmanager'
GameObject = require 'gameobject.GameObject'
Explosion = require 'gameobject.Explosion'
Gun = require 'gameobject.Gun'
Starfield = require 'Starfield'
Scenemanager = require 'scene.Scenemanager'
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
Hyperdrift = require 'Hyperdrift'

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

end

local function postSolve(a, b, coll, normalimpulse, tangentimpulse)
	local aGameObject = a:getUserData()
	local bGameObject = b:getUserData()
	aGameObject.callbacks:call("collision", aGameObject, bGameObject)
	bGameObject.callbacks:call("collision", bGameObject, aGameObject)
end


function love.load()
	love.graphics.setBackgroundColor(0, 0, 16 / 255)
	love.graphics.setFont(FONT)
	local UI_FONT = love.graphics.newFont("assets/font/spacecargo.ttf", math.floor(2 * 5))


	SET("focus", true)
	SET("BLOCK_SIZE_W", 12 * 2)
	SET("BLOCK_SIZE_H", 12 * 2)
	SET("PIXEL_SIZE_W", (UI_FONT:getWidth("a")) / 4)
	SET("PIXEL_SIZE_H", (UI_FONT:getHeight()) / 5)

	math.randomseed(os.time())

	world = love.physics.newWorld( 0, 0, true )
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	SET("World", world)

	SET(require("Statsheet"):new())
	SET(require("Save"):new())
	SET(require("Highscore"):new())
	SET(require("Starfield"):new())
	SET(require("Hyperdrift"):new())
	SET(require("Conductor"):new())
	SET(require("ShipInternals"):new())
	SET(require("Map"):new())
	SET("Cargo", require("Inventory"):new(6, 6, true))
	SET("Hud", require("ui.Hud"):new())

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
	local canvas = love.graphics.newCanvas(WINDOW_WIDTH, WINDOW_HEIGHT)
	love.graphics.setCanvas(canvas)
	love.graphics.setColor(0, 0, 16 / 255)
	love.graphics.rectangle("fill", 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)
	love.graphics.setColor(1, 1, 1)
	scenemanager:draw()
	love.graphics.setCanvas()
	love.graphics.draw(canvas, CANVAS_X, CANVAS_Y, 0, 2, 2)


	GET("Debug"):draw()
end

function love.quit()
	GET("Save"):save()
	GET("Highscore"):write()


	return false
end

function love.keypressed(key)
	GET("Debug"):keypressed(key)
end
