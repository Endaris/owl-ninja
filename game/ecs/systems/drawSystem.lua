local drawSystem = Concord.system({pool = {"texture", "position"}})

function drawSystem:loadMap(map)
    self.map = map
end

function drawSystem:draw()
    if self.map then
        self.map:draw()
    end
    for _, entity in ipairs(self.pool) do

        if entity.texture.draw then
            entity.texture.draw(entity)
        else
            love.graphics.draw(entity.texture.image, entity.position.x, entity.position.y)
        end
    end
end

return drawSystem