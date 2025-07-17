import "scripts/_imports"

local pd = playdate
local gfx = pd.graphics
pd.display.setRefreshRate(30)

ROWS = 30
COLS = 50
CELL = 8
ORIGIN = Point(0, 0)
TILE_MAP = TileMap(ROWS, COLS, CELL, ORIGIN)
TILE_MAP.__debug_draw = true

TILE_MAP:print()

BLOCK = FlyingBlock(100, 100)
BLOCK:setMap(TILE_MAP)

local function update()
    gfx.clear()
    pd.drawFPS(16, 16)
    TILE_MAP:draw()
    BLOCK:update()
    BLOCK:draw()
end


local function init()
    TILE_MAP:floodRow(2, 1)
    TILE_MAP:floodRow(ROWS - 1, 1)
    TILE_MAP:floodCol(2, 1)
    TILE_MAP:floodCol(COLS - 1, 1)

    -- Generate 50 random blocked tiles
    for i = 1, 50 do
        local row = math.random(3, ROWS - 2)
        local col = math.random(3, COLS - 2)
        TILE_MAP[row][col] = 1
    end


    pd.update = update
end


pd.update = init
