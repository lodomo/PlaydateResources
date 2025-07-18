TileMap = Class("tilemap")

---[[ Import Playdate SDK Globals
local pd = playdate
local gfx = pd.graphics
--]]

-- Define Data Members
function TileMap:init(rows, cols, cellSize, origin)
    self.__rows = rows
    self.__cols = cols
    self.__cell_size = cellSize or 16
    self.__origin = origin:copy() or Point(0, 0)

    for row = 1, self.__rows do
        self[row] = {}
        for col = 1, self.__cols do
            self[row][col] = 0
        end
    end
end

--[[ Operator Overloading
local op = TileMap
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

-- Public Properties
function TileMap:getCellSize()
    return self.__cell_size
end

-- Set Methods
function TileMap:floodRow(row, value)
    for col = 1, self.__cols do
        self[row][col] = value
    end
end

function TileMap:floodCol(col, value)
    for row = 1, self.__rows do
        self[row][col] = value
    end
end

function TileMap:getTileAt(point)
    local row = math.floor((point.y - self.__origin.y) / self.__cell_size) + 1
    local col = math.floor((point.x - self.__origin.x) / self.__cell_size) + 1

    local cell_origin = Point(
        (col - 1) * self.__cell_size + self.__origin.x,
        (row - 1) * self.__cell_size + self.__origin.y)

    if self.__debug_draw then
        gfx.drawRect(
            cell_origin.x, cell_origin.y,
            self.__cell_size, self.__cell_size)
    end

    return self[row][col], cell_origin
end

function TileMap:drawCellFilled(row, col)
    local x = self.__origin.x + (col - 1) * self.__cell_size
    local y = self.__origin.y + (row - 1) * self.__cell_size
    gfx.fillRect(x, y, self.__cell_size, self.__cell_size)
end

function TileMap:drawCellBoundary(row, col)
    local x = self.__origin.x + (col - 1) * self.__cell_size
    local y = self.__origin.y + (row - 1) * self.__cell_size
    gfx.drawRect(x, y, self.__cell_size, self.__cell_size)
end

function TileMap:draw()
    for row = 1, self.__rows do
        for col = 1, self.__cols do
            if self[row][col] == 1 then
                self:drawCellFilled(row, col)
            end
        end
    end
end
