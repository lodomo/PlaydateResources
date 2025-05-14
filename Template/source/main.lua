import "scripts/_imports"

pd.display.setRefreshRate(50)
local delta_time = DeltaTime()

local function init()
    delta_time:update()

    P1 = Point(50, 200)
    P2 = Point(200, 50)
    P3 = P1 // P2
    P4 = P2 // P1

    P1:draw(2)
    P2:draw(2)
    P3:draw(3)
    P4:draw(4)

    pd.update = Update
end

function Update()
    delta_time:update()
end

pd.update = init
