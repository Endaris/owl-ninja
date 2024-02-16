local Concord = require("game.libs.Concord")

local controllableSystem = Concord.system({pool = {"controllable", "position"}})

function controllableSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        entity.controllable.input:update()
        local x, y = entity.controllable.input:get("move")
        entity.position.x = entity.position.x + x * dt * 100
        entity.position.y = entity.position.y + y * dt * 100
    end
end

return controllableSystem