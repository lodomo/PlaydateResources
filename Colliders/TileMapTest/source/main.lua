import "scripts/_imports"

local pd = playdate
local gfx = pd.graphics
local byte_call = string.byte
pd.display.setRefreshRate(30)

local tile_map = gfx.imagetable.new("images/checker-table-8-8")

X_BOOL_50x30 = {}
for i = 1, 30 do
    X_BOOL_50x30[i] = {}
    for j = 1, 50 do
        X_BOOL_50x30[i][j] = false
    end
end

X_NUM_50x30 = {}
for i = 1, 30 do
    X_NUM_50x30[i] = {}
    for j = 1, 50 do
        X_NUM_50x30[i][j] = 0
    end
end

X_STRING_50x30 = {}
for i = 1, 30 do
    X_STRING_50x30[i] = "00000000000000000000000000000000000000000000000000"
end

local times = {
    bool = {},
    num = {},
    string = {},
}

local average_of_table = function(t)
    local sum = 0
    for _, v in ipairs(t) do
        sum = sum + v
    end
    return sum / #t
end

local random_draw = function()
    local r_i = math.random(0, 50) * 8
    local r_j = math.random(0, 30) * 8
    local tile_i = math.random(1, 64)
    local image = tile_map:getImage(tile_i) -- Get the first row of the tile map
    image:draw(r_i, r_j) -- Draw something to ensure the screen is updated
end

local function update()

    local before_bool = pd.getCurrentTimeMilliseconds()
    -- Get a random number between 1 and 30
    -- Get a random number between 1 and 50

    for i = 1, 30 do
        for j = 1, 50 do
            local value = X_BOOL_50x30[i][j]
        end
    end
    local after_bool = pd.getCurrentTimeMilliseconds()

    local before_num = pd.getCurrentTimeMilliseconds()
    for i = 1, 30 do
        for j = 1, 50 do
            local value = X_NUM_50x30[i][j]
        end
    end
    local after_num = pd.getCurrentTimeMilliseconds()

    local before_string = pd.getCurrentTimeMilliseconds()
    for i = 1, 30 do
        for j = 1, 50 do
            local val = byte_call(X_STRING_50x30[i], j)
        end
    end
    local after_string = pd.getCurrentTimeMilliseconds()

    times.bool[#times.bool + 1] = after_bool - before_bool
    times.num[#times.num + 1] = after_num - before_num
    times.string[#times.string + 1] = after_string - before_string

    local bool_avg = average_of_table(times.bool) or 0
    local num_avg = average_of_table(times.num) or 0
    local string_avg = average_of_table(times.string) or 0

    gfx.clear()
    gfx.drawText("Bool: " .. bool_avg .. " ms", 10, 10)
    gfx.drawText("Num: " .. num_avg .. " ms", 10, 30)
    gfx.drawText("String: " .. string_avg .. " ms", 10, 50)
end


local function init()
    pd.update = update
end


pd.update = init
