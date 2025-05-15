import "scripts/_imports"

pd.display.setRefreshRate(50)
local delta_time = DeltaTime()

local function init()
    delta_time:update()

    V1 = Vector(10, 10)
    V2 = Vector(40, 20)
    print(#V1)
    print(#V2)
    pd.update = Update
end

function Update()
    delta_time:update()
end

pd.update = init
