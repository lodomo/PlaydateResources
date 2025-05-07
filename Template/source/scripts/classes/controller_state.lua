ControllerState = {}
ControllerState.__index = ControllerState
setmetatable(ControllerState, { __index = Class })

function ControllerState:new()
    local obj = Class:new()
    setmetatable(obj, self)
    obj.a = ButtonState:new("a")
    obj.b = ButtonState:new("b")
    obj.up = ButtonState:new("up")
    obj.down = ButtonState:new("down")
    obj.left = ButtonState:new("left")
    obj.right = ButtonState:new("right")
    obj.dpad = Vector:new(0, 0)

    return obj
end

function ControllerState:setState()
    local state_handler = {
        AButtonDown = function()
            self.a:press()
        end,

        AButtonUp = function()
            self.a:release()
        end,

        BButtonDown = function()
            self.b:press()
        end,

        BButtonUp = function()
            self.b:release()
        end,

        upButtonDown = function()
            self.up:press()
            self.dpad:move_y(-1)
        end,

        upButtonUp = function()
            self.up:release()
            self.dpad:move_y(1)
        end,

        downButtonDown = function()
            self.down:press()
            self.dpad:move_y(1)
        end,

        downButtonUp = function()
            self.down:release()
            self.dpad:move_y(-1)
        end,

        leftButtonDown = function()
            self.left:press()
            self.dpad:move_x(-1)
        end,

        leftButtonUp = function()
            self.left:release()
            self.dpad:move_x(1)
        end,

        rightButtonDown = function()
            self.right:press()
            self.dpad:move_x(1)
        end,

        rightButtonUp = function()
            self.right:release()
            self.dpad:move_x(-1)
        end,
    }

    playdate.inputHandlers.push(state_handler)
end

function ControllerState:isPressed(button)
    button = button:lower()
    return self[button]:isPressed()
end

function ControllerState:pressedWithin(button, ms)
    button = button:lower()
    return self[button]:pressedWithin(ms)
end
