function CAT_PRINT(prefix, ...)
    local args = {...}
    local str = ""
    if prefix ~= nil then
        str = "[" .. prefix .. "]"
    end
    for _, v in ipairs(args) do
        str = str .. tostring(v) .. " "
    end
    print(str)
end

function EXTRA_VERBOSE_PRINT(...)
    if not EXTRA_VERBOSE then return end
    CAT_PRINT("EXTRA_VERBOSE", ...)
end

function VERBOSE_PRINT(...)
    if not VERBOSE then return end
    CAT_PRINT("VERBOSE", ...)
end

function DEBUG_PRINT(...)
    if not DEBUG then return end
    CAT_PRINT("DEBUG", ...)
end
