require("game.libs.batteries"):export()
local Lighter = require("game.libs.lighter")
Concord = require("game.libs.Concord")
require("game.ecs.components")
local createWorld = require("game.ecs.world")

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

function love.draw()
  love.graphics.print("Hello Owl Ninja")
  World:emit("draw")
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end