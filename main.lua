require("game.libs.batteries"):export()
local baton = require("game.libs.baton")
local Lighter = require("game.libs.lighter")
local polygonBoolean = require("game.libs.2d-polygon-boolean")
local PolyBool = require("game.libs.PolyBool")
Concord = require("game.libs.Concord")
require("game.ecs.components")
local controllableSystem = require("game.ecs.systems.controllableSystem")
local drawSystem = require("game.ecs.systems.drawSystem")
require("game.helpers")

function love.load(args)
  if args and args[1] == "debug" then
    require("lldebugger").start()
  end

  World = Concord.world()
  World:addSystem(controllableSystem)
  World:addSystem(drawSystem)
  PlayerCharacter = Concord.entity(World)
  PlayerCharacter: give("position", 100, 100)
                  :give("controllable", baton.new({
                        controls = {
                          left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
                          right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
                          up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
                          down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
                        },
                        pairs = {
                          move = {'left', 'right', 'up', 'down'}
                        },
                        joystick = love.joystick.getJoysticks()[1]
                      }))
                  :give("texture", "assets/owl/placeholder.png")
end

function love.update(dt)
  World:emit("update", dt)
end

local flattened = {}
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