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

BEEG_BLOCK = BouncingBlock(125, 125)
BEEG_BLOCK.width = 32
BEEG_BLOCK.height = 32

BEEG_FAST_BLOCK = BouncingBlock(300, 125)
BEEG_FAST_BLOCK.width = 32
BEEG_FAST_BLOCK.height = 32

BOUNCING_BLOCKS = {
    BouncingBlock(50, 50),
    BouncingBlock(120, 50),
    BouncingBlock(190, 50),
    BouncingBlock(260, 50),
    BEEG_BLOCK,
    BEEG_FAST_BLOCK
}


SPEED = 8
BOUNCING_BLOCKS[1].velocity = Vector(SPEED, SPEED)
BOUNCING_BLOCKS[2].velocity = Vector(SPEED, -SPEED)
BOUNCING_BLOCKS[3].velocity = Vector(-SPEED, SPEED)
BOUNCING_BLOCKS[4].velocity = Vector(-SPEED, -SPEED)
BEEG_BLOCK.velocity = Vector(SPEED, SPEED)
BEEG_FAST_BLOCK.velocity = Vector(SPEED * 3, SPEED * 3)

for _, block in ipairs(BOUNCING_BLOCKS) do
    block:setMap(TILE_MAP)
end

local function update()
    gfx.clear()
    pd.drawFPS(16, 16)
    TILE_MAP:draw()

    for _, block in ipairs(BOUNCING_BLOCKS) do
        block:update()
        block:draw()
        block:drawDebug()
    end
end


local function init()
    TILE_MAP:floodRow(2, 1)
    TILE_MAP:floodRow(ROWS - 1, 1)
    TILE_MAP:floodCol(2, 1)
    TILE_MAP:floodCol(COLS - 1, 1)
    pd.update = update
end


pd.update = init
