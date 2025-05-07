ClassName = {}
ClassName.__index = ClassName

-- Set Data Members
function ClassName:new(x, y)
    local obj = setmetatable({}, self)
    obj.x = x or 0
    obj.y = y or 0
    return obj
end

-- Set Methods
function ClassName:func()
    -- Function body
    -- self.datamember will access -this- tables datamember
    -- Example: self.x = self.x + 1
    -- Using : will secretly pass the object as the first argument
end

SubClass = setmetatable({}, { __index = DeltaTime })
SubClass.__index = SubClass

function SubClass:new(x, y, label)
    local obj = ClassName.new(self, x, y)
    obj.label = label or "default"
    return obj
end

function SubClass:func()
    -- Call the parent class method
    ClassName.func(self)
    -- Additional functionality for the subclass
    print("Subclass function called with label: " .. self.label)
end
