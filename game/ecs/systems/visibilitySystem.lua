local PolyBool = require("game.libs.PolyBool")
local helpers = require("game.helpers")

local visibilitySystem = Concord.system({pool = {"coneOfRevelation", "position"}})

function visibilitySystem:loadMap(map)
    local w, h = map.canvas:getDimensions()
    self.revealedPolygons = { regions = {} }
    self.hiddenPolygons = { {0, 0, w, 0, w, h, 0, h} }
    for _, b in ipairs(map.bump_collidables) do
        if b.layer and b.layer.name == "Object Layer 1" then
            local rect = {b.x, b.y, b.x + b.width, b.y, b.x + b.width, b.y + b.height, b.x, b.y + b.height}
            Lighter:addPolygon(rect)
        end
    end
end

function visibilitySystem:update(dt)
    for _, entity in ipairs(self.pool) do
        local light = entity.coneOfRevelation.light
        local pos = entity.position
        local direction = helpers.getFacingDirection(pos.faceX, pos.faceY)
        Lighter:updateLight(light, pos.x, pos.y, 1000, nil, nil, nil, nil, nil, nil, direction * - 1)
        local x, y, _ = light.x, light.y, light.radius
        local visibilityPolygon = Lighter.visibilityPolygons[light]

        if #visibilityPolygon > 0 then
            local poly = {{x, y}}
            for i=1,#visibilityPolygon do
                poly[#poly + 1] = {visibilityPolygon[i].x, visibilityPolygon[i].y}
            end
            poly[#poly + 1] = {x, y}
            if #self.revealedPolygons == 0 then
                self.revealedPolygons.regions[1] = poly
            else
                local result = PolyBool.union(self.revealedPolygons, poly)
                self.revealedPolygons = result
            end

            -- local poly = triangles[1]
            -- for i = 1, #triangles do
            --     for j = 1, #self.revealedPolygons do
            --         local result = poly2dBool(self.revealedPolygons[j], triangles[i], "or")
            --     end
            --     poly = result[1]
            -- end
            -- Lighter.triangles[light] = triangles
            -- Lighter.mergedPoly[light] = poly
        end
    end
end

function visibilitySystem:castShadows()
    love.graphics.setColor(0, 1, 0)
    for _, light in ipairs(Lighter.lights) do
        -- for i, triangle in ipairs(Lighter.triangles[light]) do
        --     love.graphics.polygon("line", triangle)
        -- end
        for i, poly in ipairs(self.revealedPolygons.regions) do
            local p = {}
            for j, vertex in ipairs(poly) do
                p[#p + 1] = vertex[1]
                p[#p + 1] = vertex[2]
            end
            love.graphics.polygon("fill", p)
        end
    end
    love.graphics.setColor(1, 1, 1)
end

return visibilitySystem