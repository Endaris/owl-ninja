require("game.libs.batteries.init"):export()
local baton = require("game.libs.baton")

Input = baton.new({
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
})

function love.load(args)
  if args and args[1] == "debug" then
    require("lldebugger").start()
  end
end

function love.update(dt)
  Input:update()
end

function love.draw()

end