import "scripts/_imports"

local pd = playdate
local gfx = pd.graphics
pd.display.setRefreshRate(1)

ROWS = 30
COLS = 50
CELL = 8
ORIGIN = Point(0, 0)
TILE_MAP = TileMap(ROWS, COLS, CELL, ORIGIN)

BOUNCING_BLOCK = BouncingBlock(20, 20)
BOUNCING_BLOCK:setMap(TILE_MAP)

local function update()
    gfx.clear()
    pd.drawFPS(16, 16)
    TILE_MAP:draw()

    BOUNCING_BLOCK:update()
    BOUNCING_BLOCK:draw()
    BOUNCING_BLOCK:drawDebug()
end


local function init()
    TILE_MAP:floodRow(2, 1)
    TILE_MAP:floodRow(ROWS - 1, 1)
    TILE_MAP:floodCol(2, 1)
    TILE_MAP:floodCol(COLS - 1, 1)
    pd.update = update
end


pd.update = init
