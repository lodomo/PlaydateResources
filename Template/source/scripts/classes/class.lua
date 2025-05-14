--[ CLASS MAP ]--
local ClassMap = {
    class_by_num = {},
    num_by_class = {},
}

function ClassMap:addClass(class)
    self.class_by_num[#self.class_by_num + 1] = class
    self.num_by_class[class.__type] = #self.class_by_num
end

---[ BASE OBJECT CLASS ]---
local Object = {}
Object.__index = Object
Object.__type = "object"

ClassMap.class_by_num[1] = Object
ClassMap.num_by_class[Object.__type] = 1

function Object:new(...)
    local instance = setmetatable({}, self)
    if self.init then self.init(instance, ...) end
    return instance
end

function Object:type()
    return self.__type
end

function Object:typeIndex()
    return ClassMap.num_by_class[self.__type]
end

function Object:typeOf(type_name)
    local other_index = ClassMap.num_by_class[type_name]
    if self:typeIndex() == other_index then return true end

    for _, v in pairs(self.__super_types) do
        if v == other_index then return true end
    end

    return false
end

function Object.deep_copy(source, dest)
    for key, value in pairs(source) do
        if type(value) ~= "table" then
            dest[key] = value
        elseif value.copy then
            dest[key] = value:copy()
        else
            dest[key] = {}
            Object.copy_table(value, dest[key])
        end
    end
end

function Object:copy()
    local temp = getmetatable(self)()
    self.deep_copy(self, temp)
    return temp
end

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

    ClassMap:addClass(class)

    setmetatable(class, {
        __index = base,
        __call = function(_, ...)
            return class:new(...)
        end
    })

    local base_num = ClassMap.num_by_class[base.__type]
    class.__super = base_num
    class.__super_types = { base_num }

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
