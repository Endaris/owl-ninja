local Concord = require("game.libs.Concord")
local bump = require("game.libs.bump")


local physicsSystem = Concord.system({pool = {"controllable", "position", "hitbox"}})

function physicsSystem:loadMap(map)
    self.map = map
    self.world = bump.newWorld()
    map:bump_init(self.world)
end

function physicsSystem:addToBumpWorld(entity)
    --self.world:add(entity, entity.position.x, entity.position.y, entity.hitbox.width, entity.hitbox.height)
end

function physicsSystem:update(dt)
    self.map:update(dt)
    for _, entity in ipairs(self.pool) do
        entity.controllable.input:update()
        local x, y = entity.controllable.input:get("move")
        if x ~= 0 or y ~= 0 then
            entity.position.faceX = x
            entity.position.faceY = y
            entity.position.moving = entity.position.moving + dt
        else
            entity.position.moving = 0
        end
        local newX, newY = entity.position.x + x * dt * 100, entity.position.y + y * dt * 100
        local actualX, actualY, cols, len = newX, newY, nil, 0--self.world:move(entity, newX, newY)
        if len >= 1 then
            -- handle collision / shimmy
        end
        entity.position.x = actualX
        entity.position.y = actualY


    end
end

return physicsSystem