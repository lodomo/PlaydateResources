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
    -- Set color to white
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(self.x - 1, self.y - 1, self.width + 2, self.height + 2)
    gfx.setColor(gfx.kColorBlack)
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
    thi is for development purposes only.

    That will be implemented later.
--]]
function BouncingBlock:checkCollisions()
    local checkPosition = Point(self.x + self.velocity.x, self.y + self.velocity.y)
    local xy_col = false
    local x_col = false
    local y_col = false

    if self.velocity.x > 0 then
        checkPosition:move_x(self.width)
    end

    if self.velocity.y > 0 then
        checkPosition:move_y(self.height)
    end

    -- Check X/Y collisions
    local tile, cell_origin, cell_size = self.__tilemap:getTileAt(checkPosition)
    if tile == 1 then
        -- If the tile is solid, we have a collision
        xy_col = true
    end

    -- Check X collisions

    -- Check Y collisions

    return xy_col or x_col or y_col
end

function BouncingBlock:update()
    if self:checkCollisions() then
        -- If there is a collision, reverse the velocity
        self.velocity.x = -self.velocity.x
        self.velocity.y = -self.velocity.y
    end

    -- self:move(self.velocity.x, self.velocity.y)
end
