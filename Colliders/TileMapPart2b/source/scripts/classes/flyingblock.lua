FlyingBlock = Class("flyingblock", Point)

---[[ Import Playdate SDK Globals
local pd = playdate
local gfx = pd.graphics
--]]

-- Define Data Members
function FlyingBlock:init(x, y)
    self.__superInit(self, x, y)
    self.width = 16 
    self.height = 16 
    self.move_speed = 5
    self.velocity = Vector(0, 0)
end

--[[ Operator Overloading
local op = ClassName
-- self + other
-- function op:__add(other) end
-- self - other
-- function op:__sub(other) end
-- self * other
-- function op:__mul(other) end
-- self / other
-- function op:__div(other) end
-- self % other
-- function op:__mod(other) end
-- self ^ other
-- function op:__pow(other) end
-- -self
-- function op:__unm() end
-- self // other
-- function op:__idiv(other) end
-- self & other
-- function op:__band(other) end
-- self | other
-- function op:__bor(other) end
-- self ~ other
-- function op:__bxor(other) end
-- ~self
-- function op:__bnot() end
-- self << other
-- function op:__shl(other) end
-- self >> other
-- function op:__shr(other) end
-- self .. other
-- function op:__concat(other) end
-- #self
-- function op:__len() end
-- self == other
-- function op:__eq(other) end
-- self < other and other > self
-- function op:__lt(other) end
-- self <= other and other >= self
-- function op:__le(other) end
--]]

-- Set Methods

--[[
    This shouldn't exist in the bouncingblock class.
    The bouncingblock should be asking the world to move,
    and the world should tell the bouncingblock if it can.
--]]
function FlyingBlock:setMap(tilemap)
    self.__tilemap = tilemap
end

function FlyingBlock:setVelocity(x, y)
    self.velocity.x = x
    self.velocity.y = y
end

function FlyingBlock:draw()
    gfx.drawRect(self.x, self.y, self.width, self.height)
end

function FlyingBlock:playerInput()
    if pd.buttonIsPressed(pd.kButtonUp) then
        self.velocity.y = -self.move_speed
    elseif pd.buttonIsPressed(pd.kButtonDown) then
        self.velocity.y = self.move_speed
    else
        self.velocity.y = 0
    end

    if pd.buttonIsPressed(pd.kButtonLeft) then
        self.velocity.x = -self.move_speed
    elseif pd.buttonIsPressed(pd.kButtonRight) then
        self.velocity.x = self.move_speed
    else
        self.velocity.x = 0
    end
end

function FlyingBlock:tileCollision()
    local y_collision = false
    local x_collision = false
    local padding = 2

    -- Check Y collisions
    if self.velocity.y ~= 0 then
        local x_axis_points = {}
        for x = self.x + padding, self.x + self.width - padding, self.__tilemap:getCellSize() do
            table.insert(x_axis_points, x)
        end

        if x_axis_points[#x_axis_points] ~= self.x + self.width - padding then
            table.insert(x_axis_points, self.x + self.width - padding)
        end

        for _, x in ipairs(x_axis_points) do
            local y_point = self.y + self.velocity.y
            if self.velocity.y > 0 then
                y_point = y_point + self.height
            end

            gfx.drawCircleAtPoint(x, y_point, 1)
            local tile_value, cell_position = self.__tilemap:getTileAt(Point(x, y_point))
            if tile_value == 1 then
                y_collision = true

                if self.velocity.y > 0 then
                    self.velocity.y = cell_position.y - self.height - self.y
                else
                    self.velocity.y = cell_position.y + self.__tilemap:getCellSize() - self.y
                end
                break
            end
        end
    end


    -- Check X collisions
    if self.velocity.x ~= 0 then
        local y_axis_points = {}
        for y = self.y + padding, self.y + self.height - padding, self.__tilemap:getCellSize() do
            table.insert(y_axis_points, y)
        end

        if y_axis_points[#y_axis_points] ~= self.y + self.height - padding then
            table.insert(y_axis_points, self.y + self.height - padding)
        end

        for _, y in ipairs(y_axis_points) do
            local x_point = self.x + self.velocity.x
            if self.velocity.x > 0 then
                x_point = x_point + self.width
            end

            gfx.drawCircleAtPoint(x_point, y, 1)
            local tile_value, cell_position = self.__tilemap:getTileAt(Point(x_point, y))
            if tile_value == 1 then
                x_collision = true

                if self.velocity.x > 0 then
                    self.velocity.x = cell_position.x - self.width - self.x
                else
                    self.velocity.x = cell_position.x + self.__tilemap:getCellSize() - self.x
                end
                break
            end
        end
    end

    if not y_collision and not x_collision and self.velocity.y ~= 0 and self.velocity.x ~= 0 then
        local x_point = self.x + self.velocity.x
        local y_point = self.y + self.velocity.y

        if self.velocity.x > 0 then
            x_point = x_point + self.width
        end

        if self.velocity.y > 0 then
            y_point = y_point + self.height
        end

        gfx.drawCircleAtPoint(x_point, y_point, 2)

        local tile_value, cell_position = self.__tilemap:getTileAt(Point(x_point, y_point))
        if tile_value == 1 then
            if self.velocity.x > 0 then
                self.velocity.x = cell_position.x - self.width - self.x
            else
                self.velocity.x = cell_position.x + self.__tilemap:getCellSize() - self.x
            end

            if self.velocity.y > 0 then
                self.velocity.y = cell_position.y - self.height - self.y
            else
                self.velocity.y = cell_position.y + self.__tilemap:getCellSize() - self.y
            end
        end
    end

end

function FlyingBlock:update()
    self:playerInput()
    self:tileCollision()
    self:move(self.velocity.x, self.velocity.y)
end
