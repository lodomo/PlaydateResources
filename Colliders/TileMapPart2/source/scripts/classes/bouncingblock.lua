BouncingBlock = Class("bouncingblock", Point)

---[[ Import Playdate SDK Globals
local pd = playdate
local gfx = pd.graphics
--]]

-- Define Data Members
function BouncingBlock:init(x, y)
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
    This shouldn't exist in the bouncingblock class.
    The bouncingblock should be asking the world to move,
    and the world should tell the bouncingblock if it can.
--]]
function BouncingBlock:setMap(tilemap)
    self.__tilemap = tilemap
end

function BouncingBlock:draw()
    gfx.fillRect(self.x, self.y, self.width, self.height)
end

function BouncingBlock:drawDebug()
    -- At the top left corner draw the full velocity
    gfx.drawLine(
        self.x, self.y,
        self.x + self.velocity.x, self.y + self.velocity.y
    )

    -- At the bottom right corner draw the projected velocity
    gfx.drawLine(
        self.x + self.width, self.y + self.height,
        self.x + self.width + self.velocity.x, self.y + self.height + self.velocity.y
    )

    -- At the top right draw the velocity
    gfx.drawLine(
        self.x + self.width, self.y,
        self.x + self.width + self.velocity.x, self.y + self.velocity.y
    )

    -- At the bottom left draw the velocity
    gfx.drawLine(
        self.x, self.y + self.height,
        self.x + self.velocity.x, self.y + self.height + self.velocity.y
    )
end

--[[
    This should be done by the world, not the bouncingblock.
    this is for development purposes only.

    That will be implemented later.
--]]
function BouncingBlock:checkCollisions()
    local checkX = self.__tilemap:getTileAt(Point(self.x + self.velocity.x, self.y))
    local checkY = self.__tilemap:getTileAt(Point(self.x, self.y + self.velocity.y))
    local collision = false

    if checkX == 1 then
        self.velocity.x = -self.velocity.x
        self.x = self.x + self.velocity.x
        collision = true
    end

    if checkY == 1 then
        self.velocity.y = -self.velocity.y
        self.y = self.y + self.velocity.y
        collision = true
    end

    return collision
end

function BouncingBlock:update()
    if not self:checkCollisions() then
        self.x = self.x + self.velocity.x
        self.y = self.y + self.velocity.y
    end
end
