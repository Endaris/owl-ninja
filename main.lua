require("game.libs.batteries"):export()
local Lighter = require("game.libs.lighter")
Concord = require("game.libs.Concord")
require("game.ecs.components")
local createWorld = require("game.ecs.world")
local lighter = Lighter()

local wall = {
    100, 100,
    300, 100,
    300, 300,
    100, 300
}

lighter:addPolygon(wall)

local lightX, lightY = 500, 500

-- addLight signature: (x,y,radius,r,g,b,a)
local light = lighter:addLight(lightX, lightY, 500, 1, 0.5, 0.5, nil, nil, math.pi / 2, math.pi / 1.5)--) 0)


function love.load(args)
  if args and args[1] == "debug" then
    require("lldebugger").start()
  end
  World = createWorld("assets/maps/test.lua")
  World:addEntity(require("game.ecs.entities.playerCharacter"))
end

function love.update(dt)
  lightX, lightY = love.mouse.getPosition()
  lighter:updateLight(light, lightX, lightY, nil, nil, nil, nil, nil, nil, nil, love.timer.getTime() % (2 * math.pi))
  World:emit("update", dt)
end

function love.draw()
  love.graphics.print("Hello Owl Ninja")
  World:emit("draw")
  love.graphics.setColor(0.3, 0.3, 0.3)
  love.graphics.polygon('fill', wall)
  love.graphics.setColor(1, 1, 1)
  lighter:drawVisibilityPolygon(light)
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end