import "scripts/_imports"

pd.display.setRefreshRate(50)
local delta_time = DeltaTime()

local function init()
    delta_time:update()
    pd.update = Update
end

function Update()
    delta_time:update()
end

pd.update = init
