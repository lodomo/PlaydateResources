import "scripts/_imports"

pd.display.setRefreshRate(50)

DEBUG = true
VERBOSE = true
EXTRA_VERBOSE = false

DEBUG_PRINT("Debugging is enabled")
VERBOSE_PRINT("Verbose output is enabled")
EXTRA_VERBOSE_PRINT("Extra verbose output is enabled")

DELTA_TIME = DeltaTime:new()

local function init()
    DEBUG_PRINT("Initializing...")
end

function Update()
    DELTA_TIME:update()
    pd.drawFPS(0, 0)
end

init()
pd.update = Update
DEBUG_PRINT("Game loop started")
