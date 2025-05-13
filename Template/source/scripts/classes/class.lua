---[ BASE OBJECT CLASS ]---
local Object = {}
Object.__index = Object
Object.__type = "object"

function Object:new(...)
    local instance = setmetatable({}, self)
    if self.init then self.init(instance, ...) end
    return instance
end

function Object:type()
    return self.__type
end

function Object:typeOf(type_name)
    if self:type() == type_name then return true end
    if self.__super then return self.__super:typeOf(type_name) end
    return false
end

--[[ TODO BETTER
function Object:copy()
    local temp = getmetatable(self)()
    for k, v in pairs(self) do
        if type(v) == "table" then
            temp[k] = v:copy()
        else
            temp[k] = v
        end
    end
    return temp
end
--]]

function Object:print()
    print("Class: " .. self:type())
    if self.__super_types then
        local in_str = "Inherited Classes: "
        for i = 1, #self.__super_types do
            in_str = in_str .. self.__super_types[i].__type
            if i < #self.__super_types then
                in_str = in_str .. ", "
            end
        end
        print(in_str)
    end
    for k, v in pairs(self) do
        print(k, v)
    end
end

-- [ CLASS CREATION FUNCTION ] --
function Class(name, base)
    base = base or Object
    local class = {}
    class.__index = class
    class.__type = name

    setmetatable(class, {
        __index = base,
        __call = function(_, ...)
            return class:new(...)
        end
    })

    class.__super = base
    class.__super_types = { base }

    if base.__super_types then
        for i = 1, #base.__super_types do
            table.insert(class.__super_types, base.__super_types[i])
        end
    end

    -- Get the operator overloading functions from the base class
    for k, v in pairs(base) do
        if type(k) == "string" and k:match("^__") and type(v) == "function" then
            class[k] = v
        end
    end

    return class
end
