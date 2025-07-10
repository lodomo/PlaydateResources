Line = Class("line")

-- Define Data Members
function Line:init(point_or_x1, point_or_y1, x2, y2)
    if point_or_x1:type() == "point" then
        self.a = point_or_x1
        self.b = point_or_y1
    else
        self.a = Point(point_or_x1, point_or_y1)
        self.b = Point(x2, y2)
    end
end

---[[ Operator Overloading
local op = Line
-- self + other
-- function op:__add(other) end
-- self - other
-- function op:__sub(other) end
-- self * other
-- function op:__mul(other) end
-- self / other
-- function op:__div(other) end
-- self % other
-- function op:__mod(other) end
-- self ^ other
-- function op:__pow(other) end
-- -self
-- function op:__unm() end
-- self // other
-- function op:__idiv(other) end
-- self & other
-- function op:__band(other) end
-- self | other
-- function op:__bor(other) end
-- self ~ other
-- function op:__bxor(other) end
-- ~self
-- function op:__bnot() end
-- self << other
-- function op:__shl(other) end
-- self >> other
-- function op:__shr(other) end
-- self .. other
-- function op:__concat(other) end
-- #self
function op:__len()
    local x = self.a.x - self.b.x
    local y = self.a.y - self.b.y
    return math.sqrt(x * x + y * y)
end
-- self == other
-- function op:__eq(other) end
-- self < other and other > self
-- function op:__lt(other) end
-- self <= other and other >= self
-- function op:__le(other) end
--]]

-- Set Methods
function Line:func()
    -- Function body
    -- self.datamember will access -this- tables datamember
    -- Example: self.x = self.x + 1
    -- Using : will secretly pass the object as the first argument
end
