local helpers = {}

function helpers.getFacingDirection(x, y)
    -- in screen coordinates, positive x is RIGHT
    local fX = x
    -- in screen coordinates, positive y is DOWN
    -- let's pretend these are cartesian coordinates though
    local fY = -1 * y
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
    return angle
end

return helpers