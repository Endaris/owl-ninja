local drawSystem = Concord.system({pool = {"texture", "position"}})

function drawSystem:draw()
    for _, entity in ipairs(self.pool) do
        love.graphics.draw(entity.texture.image, entity.position.x, entity.position.y)
    end
end

return drawSystem