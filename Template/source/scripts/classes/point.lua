Point = Class("point")

---[[ Operator Overloading
local op = Point

-- self + other
function op:__add(other)
    return getmetatable(self)(self.x + other.x, self.y + other.y)
end

-- self - other
function op:__sub(other)
    return getmetatable(self)(self.x - other.x, self.y - other.y)
end

-- -self
function op:__unm()
    return getmetatable(self)(-self.x, -self.y)
end

-- self // other
-- Orthogonal Projection
function op:__idiv(other)
    return getmetatable(self)(self.x, other.y)
end

-- self == other
function op:__eq(other)
    return self.x == other.x and self.y == other.y
end

-- self < other
function op:__lt(other)
    return self.x < other.x and self.y < other.y
end

-- self <= other
function op:__le(other)
    return self.x <= other.x and self.y <= other.y
end
--]]

-- Class Data Members
function Point:init(x, y)
    self.x = x or 0
    self.y = y or 0
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
    if not radius then
        return DrawPixel(self.x, self.y)
    end

    return FillCircleAtPoint(self.x, self.y, radius)
end

