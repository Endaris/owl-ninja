Concord.component("position", function(component, x, y)
    component.x = x or 0
    component.y = y or 0
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