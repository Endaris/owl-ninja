Concord.component("position", function(component, x, y)
    component.x = x or 0
    component.y = y or 0
end)

Concord.component("texture", function(component, path)
    component.path = path
    component.image = love.graphics.newImage(path)
end)

Concord.component("controllable", function(component, batonInput)
    component.input = batonInput
end)