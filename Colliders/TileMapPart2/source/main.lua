import "scripts/_imports"

local pd = playdate
local gfx = pd.graphics
pd.display.setRefreshRate(30)

TILE_MAP = {
    getCell = function(self, x, y)
        local row = math.floor(y / CELL) + 1
        local col = math.floor(x / CELL) + 1
        return self[row][col]
    end,
    drawCell = function(self, x, y)
        local row = math.floor(y / CELL) + 1
        local col = math.floor(x / CELL) + 1
        local tile = self[row][col]
        if tile == 1 then
            gfx.drawRect((col - 1) * CELL, (row - 1) * CELL, CELL, CELL) -- x, y, width, height
        end
    end,
}

ROWS = 30
COLS = 50
CELL = 8


PLAYER = {
    x = 20,
    y = 20,
    width = 16,
    height = 16,
    velocity = {
        x = 4,
        y = 4,
    },
    drawVelocity = function(self)
        local l_x = self.x
        local l_y = self.y
        local r_x = self.x + self.width
        local r_y = self.y + self.height

        gfx.drawLine(l_x, l_y, l_x + self.velocity.x, l_y + self.velocity.y)
        gfx.drawLine(r_x, l_y, r_x + self.velocity.x, l_y + self.velocity.y)
        gfx.drawLine(l_x, r_y, l_x + self.velocity.x, r_y + self.velocity.y)
        gfx.drawLine(r_x, r_y, r_x + self.velocity.x, r_y + self.velocity.y)
    end,
    draw = function(self)
        self:drawVelocity()
        gfx.fillRect(self.x, self.y, self.width, self.height) -- x, y, width, height
    end,
    update = function(self)
        self.x = self.x + self.velocity.x
        self.y = self.y + self.velocity.y
    end,
}



local function update()
    gfx.clear()
    pd.drawFPS(16, 16)
    for row = 1, #TILE_MAP do
        for col = 1, #TILE_MAP[row] do
            local tile = TILE_MAP[row][col]
            if tile == 1 then
                gfx.fillRect((col - 1) * CELL, (row - 1) * CELL, CELL, CELL) -- x, y, width, height
            end
        end
    end

    PLAYER:update()
    PLAYER:draw()
end


local function init()
    for row = 1, ROWS do
        TILE_MAP[row] = {}
        for col = 1, COLS do
            if row == 2 or row == ROWS - 1 or col == 2 or col == COLS - 1 then
                TILE_MAP[row][col] = 1
            else
                TILE_MAP[row][col] = 0
            end
        end
    end

    pd.update = update
end


pd.update = init
