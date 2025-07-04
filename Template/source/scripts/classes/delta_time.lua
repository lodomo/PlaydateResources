DeltaTime = Class("deltatime")

local INT_MAX = math.huge
local GetCurrentTimeMilliseconds = playdate.getCurrentTimeMilliseconds

function DeltaTime:init()
    self.current = 0
    self.last = 0
    self.delta = 0
    self.now = GetCurrentTimeMilliseconds
end

function DeltaTime:update()
    self.current = self.now()
    self.delta = (self.current - self.last) / 1000

    if self.current < self.last then
        self.delta = (self.current + INT_MAX - self.last + 1) / 1000
    end

    self.last = self.current
    return self.delta
end

function DeltaTime:get()
    return self.delta
end

function DeltaTime:get_ms()
    return self.delta * 1000
end

function DeltaTime:peek()
    return (self.now() - self.last) / 1000
end

function DeltaTime:peek_ms()
    return (self.now() - self.last)
end
