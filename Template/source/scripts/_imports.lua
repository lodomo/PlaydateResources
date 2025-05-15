---[[ Playdate Core Libs 
-- import "CoreLibs/3d"
-- import "CoreLibs/accelerometer"
-- import "CoreLibs/animation"
-- import "CoreLibs/animator"
-- import "CoreLibs/crank"
-- import "CoreLibs/easing"
-- import "CoreLibs/frameTimer"
import "CoreLibs/graphics"
-- import "CoreLibs/keyboard"
-- import "CoreLibs/logic"
-- import "CoreLibs/math"
-- import "CoreLibs/nineslice"
-- import "CoreLibs/object"
-- import "CoreLibs/qrcode"
-- import "CoreLibs/save"
-- import "CoreLibs/sprites"
-- import "CoreLibs/strict"
-- import "CoreLibs/string"
-- import "CoreLibs/timer"
-- import "CoreLibs/ui"
--]]

---[[ Playdate Globals
pd = playdate
GetCurrentTimeMilliseconds = pd.getCurrentTimeMilliseconds

gfx = pd.graphics
DrawPixel = gfx.drawPixel
DrawLine = gfx.drawLine
FillCircleAtPoint = gfx.fillCircleAtPoint
DrawRect = gfx.drawRect
DrawFillRect = gfx.fillRect

InputHandlers = pd.inputHandlers
--]]

---[[ Global Constants
PI = math.pi
TAU = math.pi * 2
INF = math.huge
S_WIDTH = 400
S_HEIGHT = 240
--]]

---[[ Utilities and Helpers
-- These MAY use the Playdate Globals
import "scripts/utils"
--]]


---[[ Class Imports
--- These MAY use the Playdate Globals
import("scripts/libs/class") -- Every class depends on this

import("scripts/classes/delta_time")

import("scripts/classes/point")
    import("scripts/classes/vector") -- Extends point
    --import("scripts/classes/shapes") -- Extends point

-- import("scripts/classes/button_state")
-- import("scripts/classes/controller_state") -- Depends on button_state
--]]
