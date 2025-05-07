Point = {}
Point.__index = Point
setmetatable(Point, { __index = Class })

-- Class Data Members
function Point:new(x, y)
    local obj = Class:new()
    setmetatable(obj, self)
    obj.x = x or 0
    obj.y = y or 0
    return obj
end

function Point:move_x(x)
    self.x = self.x + x
end

function Point:move_y(y)
    self.y = self.y + y
end

function Point:move(x, y)
    self:move_x(x)
    self:move_y(y)
end

function Point:draw(radius)
    if radius == nil then
        return DrawPixel(self.x, self.y)
    end

    return FillCircleAtPoint(self.x, self.y, radius)
end
