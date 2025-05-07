--[[ Delta Time Documentation
--]]
DeltaTime = {}
DeltaTime.__index = DeltaTime
setmetatable(DeltaTime, { __index = Class })

-- Set Data Members
function DeltaTime:new()
    local obj = Class:new()
    setmetatable(obj, self)
    obj.current = 0
    obj.last = 0
    obj.delta = 0
    obj.getTime = GetCurrentTimeMilliseconds
    return obj
end

-- Set Methods
function DeltaTime:update()
    self.current = self.getTime()
    self.delta = (self.current - self.last) / 1000
    self.last = self.current
end

function DeltaTime:get()
    return self.delta
end

function DeltaTime:peek()
    return (self.getTime() - self.last) / 1000
end
