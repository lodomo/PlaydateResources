-- Lodomo Lua Class System
-- Copyright (c) 2025 Lodomo.Dev

--  CLASS MAP
--  This map will be used as a registry for all classes created.
--  class_by_num: A table that maps class numbers to class objects.
--  num_by_class: A table that maps class names to their respective numbers.
local ClassMap = {
    class_by_num = {},
    num_by_class = {},
}

-- Add a class to the ClassMap.
-- Updates both class_by_num and num_by_class tables.
-- @param class The class object to be added.
function ClassMap:addClass(class)
    self.class_by_num[#self.class_by_num + 1] = class
    self.num_by_class[class.__type] = #self.class_by_num
end

--  BASE OBJECT CLASS
--  This is the base class from which all other classes will inherit.
--  It provides basic functionality for creating objects, copying them, and checking their types.
--  To add a function to ALL objects, add it to this class.
local Object = {}
Object.__index = Object
Object.__type = "object"

-- Update empty class map
ClassMap.class_by_num[1] = Object
ClassMap.num_by_class[Object.__type] = 1

--  Creates a new instance of a defined class.
--  @param ... The parameters to be passed to the class constructor
--  @return A new object of that class.
--
--  This will be set to __call in the class metatable.
--  This allows the class to be instantiated using the syntax:
--  `local obj = ClassName(...)`
function Object:new(...)
    local instance = setmetatable({}, self)
    if self.init then self.init(instance, ...) end
    return instance
end

--  Get the class name of the object.
--  @return The class name of the object.
function Object:type()
    return self.__type
end

-- Get the class number of the object.
-- @return The class number of the object.
-- This number is NOT reliable to use for anything.
-- The map can and will change, and is generated at runtime.
function Object:typeIndex()
    return ClassMap.num_by_class[self.__type]
end

-- Check if the object is of a specific type.
-- @param type_name The name of the type to check against.
-- @returns boolean
--
-- This will return true if the object is of the specific type, or derived from
-- that type.
function Object:typeOf(type_name)
    local other_index = ClassMap.num_by_class[type_name]
    if self:typeIndex() == other_index then return true end

    for _, v in pairs(self.__super_types) do
        if v == other_index then return true end
    end

    return false
end

--  Copy a table, including nested tables, and nested objects.
--  @param source The table to be copied.
--  @param dest The table to copy to.
--  @return nil
function Object.__deep_copy(source, dest)
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

--  Copy an object to a new object.
--  @return A new object with the same properties as the original.
function Object:copy()
    local temp = getmetatable(self)()
    self.__deep_copy(self, temp)
    return temp
end

--  Print the class name, and all properties of the object.
--  Work in progress. TODO
--  @return nil
function Object:print()
    print("No Custom Print Function Defined")
    print("Defaulting to obj:dumpPrint()")
    self:dumpPrint()
end

function Object:dumpPrint()
    print("Class: " .. self:type())

    if self.__super_types then
        local in_str = "Inherited Classes: "
        for i = 1, #self.__super_types do
            local super_index = self.__super_types[i]
            local super_class = ClassMap.class_by_num[super_index]
            if super_class and super_class.__type then
                in_str = in_str .. super_class.__type
            end

            if i < #self.__super_types then
                in_str = in_str .. ", "
            end
        end
        print(in_str)
    end

    print("Properties:")
    for key, value in pairs(self) do
        if type(value) ~= "function" then
            print("  " .. key .. ": " .. tostring(value))
        end
    end

    print("Methods:")
    local seen = {}
    local current = getmetatable(self)

    while current do
        for key, value in pairs(current) do
            if type(value) == "function" and not key:match("^__") and not seen[key] then
                print("  " .. key)
                seen[key] = true
            end
        end
        current = getmetatable(current)
    end
end

function Object:__superInit(...)
    local super = ClassMap.class_by_num[self.__super]
    if super and super.init then
        super.init(self, ...)
    end
end

--  CLASS CREATION FUNCTION
--  Create a new class that inherits from the base class.
--  @param name The name of the new class.
--  @param base The base class to inherit from. Defaults to Object.
--  @return A new class object.
--
--  Naming convention:
--      BaseClass = Class("baseclass")
--      DerivedClass = Class("derivedclass", BaseClass)
--
--  New objects can be created using the syntax:
--      local base = BaseClass(...)
--      local derived = DerivedClass(...)
function Class(name, base)
    base = base or Object -- Default to Object if no base class is provided
    local class = {}
    class.__index = class
    class.__type = name

    ClassMap:addClass(class)

    -- Set to inherit methods from the base class
    -- Remove the need for :new() to create a new object
    setmetatable(class, {
        __index = base,
        __call = function(_, ...)
            return class:new(...)
        end
    })

    -- Inherit all the class indexes from the base class
    local base_num = ClassMap.num_by_class[base.__type]
    class.__super = base_num
    class.__super_types = { base_num }

    if base.__super_types then
        for i = 1, #base.__super_types do
            table.insert(class.__super_types, base.__super_types[i])
        end
    end

    -- Inherit all the operator overloading functions from the base class
    for k, v in pairs(base) do
        if type(k) == "string" and k:match("^__") and type(v) == "function" then
            class[k] = v
        end
    end

    return class
end
