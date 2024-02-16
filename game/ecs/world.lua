local physicsSystem = require("game.ecs.systems.physicsSystem")
local drawSystem = require("game.ecs.systems.drawSystem")
local bump = require("game.libs.bump")
local sti = require("game.libs.sti")


return function(mapPath)
    local world = Concord.world()
    world:addSystem(physicsSystem)
    world:addSystem(drawSystem)


    local map = sti(mapPath, {"bump"})
    world:emit("loadMap", map)

    world.onEntityAdded = function(w, entity)
        if entity.hitbox then
            w:getSystem(physicsSystem):addToBumpWorld(entity)
        end
    end

    return world
end
