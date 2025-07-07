Player = Class("player", Point)

---[[ Import Playdate SDK Globals
local pd = playdate
local gfx = pd.graphics
--]]

-- Define Data Members
function Player:init(x, y)
    self.__superInit(self, x, y)
    self.width = 16
    self.height = 16
    self.velocity = Vector(4, 4)
end

--[[ Operator Overloading
local op = ClassName
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
-- function op:__len() end
-- self == other
-- function op:__eq(other) end
-- self < other and other > self
-- function op:__lt(other) end
-- self <= other and other >= self
-- function op:__le(other) end
--]]

-- Set Methods

--[[
    This shouldn't exist in the player class.
    The player should be asking the world to move,
    and the world should tell the player if it can.
--]]
function Player:setMap(tilemap)
    self.__tilemap = tilemap
end

function Player:draw()
    gfx.fillRect(self.x, self.y, self.width, self.height)
end

function Player:update()
    local projected = Point(
        self.x + self.velocity.x,
        self.y + self.velocity.y
    )

    -- THE PLAYER SHOULD NEVER BE DOING THIS MATH
    -- THIS SHOULD GET PASSED TO A COLLISION MANAGER
    local tile, origin, cell_size = self.__tilemap:getTileAt(projected)

    print(tile)

    if tile ~= 1 then
        self.x = projected.x
        self.y = projected.y
        return
    end

    print("collision detected")
    error("Exiting due to collision")

    -- Determine which side of the tile we hit
    local left = origin.x
    local right = origin.x + cell_size
    local top = origin.y
    local bottom = origin.y + cell_size

    if self.x + self.width < left then
        self.x = left - self.width
        self.velocity.x = -self.velocity.x
    elseif self.x > right then
        self.x = right
        self.velocity.x = -self.velocity.x
    end

    if projected.y + self.height < top then
        self.y = top - self.height
        self.velocity.y = -self.velocity.y
    elseif projected.y > bottom then
        self.y = bottom
        self.velocity.y = -self.velocity.y
    end
end
