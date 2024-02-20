local anim8 = require("game.libs.anim8")
local lighter = require("game.libs.lighter")

Concord.component("position", function(component, x, y)
    component.x = x or 0
    component.y = y or 0
    component.faceX = 0
    component.faceY = 1
    component.moving = 0
end)

Concord.component("texture", function(component, path, drawFunc)
    component.path = path
    component.image = love.graphics.newImage(path)
    component.draw = drawFunc
end)

Concord.component("controllable", function(component, batonInput)
    component.input = batonInput
end)

-- using bump, all hitboxes and collisions assume AABB rectangles
Concord.component("hitbox", function(component, width, height)
    component.width = width
    component.height = height
end)

Concord.component("animation", function(component, atlas, width, height, offsetX, offsetY)
    component.atlas = love.graphics.newImage(atlas)
    local w, h = component.atlas:getDimensions()
    component.grid = anim8.newGrid(width, height, w, h, offsetX or 0, offsetY or 0)
end)

Concord.component("coneOfRevelation", function(component, angle)
    component.angle = angle
    component.light = Lighter:addLight(0, 0, 500, 1, 1, 1, nil, nil, angle)
end)