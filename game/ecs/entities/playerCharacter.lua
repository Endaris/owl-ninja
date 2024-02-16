local baton = require("game.libs.baton")
local anim8 = require("game.libs.anim8")

local function getDirection(pc)
    -- in screen coordinates, positive x is RIGHT
    local fX = pc.position.faceX
    -- in screen coordinates, positive y is DOWN
    -- let's pretend these are cartesian coordinates though
    local fY = -1 * pc.position.faceY
    local angle
    if fX == 0 then
        if fY > 0 then
            angle = math.pi / 2
        elseif fY < 0 then
            angle = 3 * math.pi / 2
        else
            error()
        end
    elseif fY == 0 then
        if fX > 0 then
            angle = 0
        elseif fX < 0 then
            angle = math.pi
        else
            error()
        end
    else
        if  (fY > 0 and fX > 0) then
            angle = math.atan(fY / fX)
        elseif  (fX < 0 and fY > 0) then
            angle = math.atan(fX / fY) + math.pi
        elseif (fY < 0 and fX < 0) then
            angle = math.atan(fY / fX) + math.pi
        else
            angle = math.atan(fX / fY) + 2 * math.pi
        end
    end
    -- offset by half an eight of a circle to have the center of each area point in the cardinal direction
    angle = angle + math.pi / 8
    local offset = math.abs(angle / (math.pi / 4))
    return math.floor(offset)
end

local function isMoving(pc)
    local x, y = pc.controllable.input:get("move")
    return x ~= 0 or y ~= 0
end

local function getColumnFlip(idx)
    if idx == 0 then
        -- facing right
        return 3, true
    elseif idx == 1 then
        -- facing topright
        return 4, true
    elseif idx == 2 then
        -- facing top
        return 5, false
    elseif idx == 3 then
        -- facing topleft
        return 4, false
    elseif idx == 4 then
        -- facing left
        return 3, false
    elseif idx == 5 then
        -- facing bottomleft
        return 2, false
    elseif idx == 6 then
        -- facing bottom
        return 1, false
    elseif idx == 7 then
        -- facing bottomright
        return 2, true
    end
end

local function draw(pc)
    local sector = getDirection(pc)
    local row
    local column, flip = getColumnFlip(sector)
    if not isMoving(pc) then
        row = 1
    else
       row = math.floor(pc.position.moving % 1 / (1/6)) + 1
    end

    local xScale = 2
    local yScale = 2

    if flip then
        xScale = xScale * -1
    end

    love.graphics.draw(pc.animation.atlas, pc.animation.grid:getFrames(column, row)[1], pc.position.x, pc.position.y, 0, xScale, yScale, 16, 16)
end

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
                :give("texture", "assets/owl/owl.png", draw)
                :give("animation", "assets/owl/owl.png", 32, 32)
                :give("hitbox", 30, 30)

return PlayerCharacter