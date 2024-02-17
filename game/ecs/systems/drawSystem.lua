local drawSystem = Concord.system({pool = {"texture", "position"}})

function drawSystem:init()
    local x, y = love.graphics.getDimensions()
    self.canvas = love.graphics.newCanvas(x / 2, y / 2)
end

function drawSystem:loadMap(map)
    self.map = map
end

function drawSystem:draw()
    love.graphics.setCanvas(self.canvas)
    if self.map then
        self.map:draw()
    end

    if lldebugger then
        love.graphics.setColor(1, 0, 0, 0.7)
        self.map:bump_draw(World:getSystem(require("game.ecs.systems.physicsSystem")).world)
        love.graphics.setColor(1, 1, 1, 1)
    end

    for _, entity in ipairs(self.pool) do

        if entity.texture.draw then
            entity.texture.draw(entity)
        else
            love.graphics.draw(entity.texture.image, entity.position.x, entity.position.y)
        end
    end
    love.graphics.setCanvas()
    love.graphics.draw(self.canvas, 0, 0, 0, 2, 2)
end

return drawSystem