Vector = Class("vector", Point)

function Vector:init(x, y)
    self.__super.init(self, x, y)
end

---[[ Operator Overloading
local op = ClassName
-- self + other - Handled by Point
-- self - other - Handled by Point
-- -self - Handled by Point
-- self // other - Orthogonal Projection - Handled by Point
-- self == other - Handled by Point
-- self < other - Handled by Point
-- self <= other - Handled by Point

-- self * other - Dot Product NOT 
function op:__mul(other)
    if other.typeOf and other:typeOf("vector") then
        return (self.x * other.x) + (self.y * other.y)
    end
end

-- #self
function op:__len()
    return math.sqrt(self.x * self.x + self.y * self.y)
end
--]]

function Vector:draw(origin)
    if origin == nil then
        return DrawLine(0, 0, self.x, self.y)
    end

    return DrawLine(origin.x, origin.y, self.x + origin.x, self.y + origin.y)
end

--[[
--Normalize the vector, the vector data is changed
--]]
function Vector:normalize()
    local length = math.sqrt(self.x * self.x + self.y * self.y)
    if length == 0 then
        self.x = 0
        self.y = 0
        return
    end

    self.x = self.x / length
    self.y = self.y / length
end

--[[
--Normalize the vector, the vector data is not changed, it is returned in a new object.
--]]
function Vector:getNormalized()
    local temp = Vector:new(self.x, self.y)
    temp:normalize()
    return temp
end
