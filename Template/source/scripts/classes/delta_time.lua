DeltaTime = Class("deltatime")

function DeltaTime:init()
    self.current = 0
    self.last = 0
    self.delta = 0
    self.correct_overflow = 2^32
    self.now = GetCurrentTimeMilliseconds
end

--[[ TODO OVERFLOW DETECTION
function DeltaTime:update()
    self.current = self.now()

    self.delta = self.current - self.last
    if self.delta < 0 then
        -- Handle overflow
        self.delta = self.delta 
    end


    self.last = self.current
    return self.delta
end
--]]

function DeltaTime:get()
    return self.delta
end

function DeltaTime:peek()
    return (self.now() - self.last) / 1000
end
