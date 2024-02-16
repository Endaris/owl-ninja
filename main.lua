require("lldebugger").start()

require("game.libs.batteries"):export()
local baton = require("game.libs.baton")
local Lighter = require("game.libs.lighter")
Concord = require("game.libs.Concord")
require("game.ecs.components")
local createWorld = require("game.ecs.world")

function love.load(args)
  World = createWorld("assets/maps/testmap.lua")
  PlayerCharacter = Concord.entity()
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
                  :give("hitbox", 30, 30)
  World:addEntity(PlayerCharacter)
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