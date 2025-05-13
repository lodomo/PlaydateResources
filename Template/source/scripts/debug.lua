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
