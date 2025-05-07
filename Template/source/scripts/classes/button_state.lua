ButtonState = {}
ButtonState.__index = ButtonState
setmetatable(ButtonState, { __index = Class })

-- Class Data Members
function ButtonState:new(name)
    local obj = Class:new()
    setmetatable(obj, self)

    if name ~= nil then
        obj.name = name
    end

    obj.pressed = false
    obj.time = GetCurrentTimeMilliseconds()
    return obj
end

-- Class Methods
function ButtonState:press()
    self.pressed = true
    self.time = GetCurrentTimeMilliseconds()
    EXTRA_VERBOSE_PRINT(self.name .. "\t pressed     " .. self.time)
end

function ButtonState:release()
    self.pressed = false
    self.time = GetCurrentTimeMilliseconds()
    EXTRA_VERBOSE_PRINT(self.name .. "\t released    " .. self.time)
end

function ButtonState:isPressed()
    return self.pressed
end

function ButtonState:pressedWithin(ms)
    return (GetCurrentTimeMilliseconds - self.time) <= ms
end
