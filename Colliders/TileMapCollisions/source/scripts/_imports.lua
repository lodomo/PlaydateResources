---[[ Playdate Core Libs 
import "CoreLibs/graphics"
--]]

--[[ Handy Playdate SDK References

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

import("scripts/classes/point")
import("scripts/classes/vector") -- Extends point
--]]
