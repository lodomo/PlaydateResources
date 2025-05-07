Class = {}
Class.__index = Class
Class.name = "Default Name"

function Class:new()
    local obj = setmetatable({}, self)
    return obj
end

function Class:print()
    for k, v in pairs(self) do
        print(k, v)
    end
end
