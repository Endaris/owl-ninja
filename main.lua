require("game.libs.batteries"):export()
local lighter = require("game.libs.lighter")
Concord = require("game.libs.Concord")
require("game.ecs.components")
local createWorld = require("game.ecs.world")
Lighter = lighter()

function love.load(args)
  if args and args[1] == "debug" then
    require("lldebugger").start()
  end
  World = createWorld("assets/maps/testmap.lua")
  World:addEntity(require("game.ecs.entities.playerCharacter"))
end

function love.update(dt)
  World:emit("update", dt)
end

local x, y = love.graphics.getDimensions()
local canvas = love.graphics.newCanvas(x / 2, y / 2)
function love.draw()
  love.graphics.print("Hello Owl Ninja")
  love.graphics.setCanvas(canvas)

  World:emit("draw")
  World:emit("castShadows")

  love.graphics.setCanvas()
  love.graphics.draw(canvas, 0, 0, 0, 2, 2)
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end