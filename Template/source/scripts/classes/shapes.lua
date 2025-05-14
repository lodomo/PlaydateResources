--[[ NEEDS TO BE REDONE
Shape = {}
Shape.__index = Shape
Shape.name = "Default Shape"
setmetatable(Shape, { __index = Point })

function Shape:new(x, y, width, height, filled)
    local obj = Point:new(x, y)
    setmetatable(obj, self)
    obj.width = width or 0
    obj.height = height or 0
    obj.filled = filled or false
    return obj
end

function Shape:fill()
    self.filled = true
end

function Shape:empty()
    self.filled = false
end

function Shape:left()
    return math.min(self.x, self.x + self.width)
end

function Shape:right()
    return math.max(self.x, self.x + self.width)
end

function Shape:top()
    return math.min(self.y, self.y + self.height)
end

function Shape:bottom()
    return math.max(self.y, self.y + self.height)
end


--[[
-- A fixed rect cannot be rotated, it is always aligned with the screen.
-- A fixed rect is drawn from the top left corner, to the bottom right corner
-- (assuming the width and height are positive)
--]]
--[[
Rect = {}
Rect.__index = Rect
Rect.name = "Default Rectangle"
setmetatable(Rect, { __index = Shape })

function Rect:new(x, y, width, height, filled)
    local obj = Shape:new(x, y, width, height, filled)
    setmetatable(obj, self)
    return obj
end

function Rect:draw()
    if self.filled then
        return DrawFillRect(self.x, self.y, self.width, self.height)
    end

    return DrawRect(self.x, self.y, self.width, self.height)
end
--]]
