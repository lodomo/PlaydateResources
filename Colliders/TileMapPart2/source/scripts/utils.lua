--[[
-- Linear Interpolation
-- @param a: start value
-- @param b: end value
-- @param t: interpolation factor
-- -- @return: interpolated value
--
-- When t < 0, extrapolate beyond a
-- When t > 1, extrapolate beyond b
--]]
function Lerp(a, b, t)
    return a + (b - a) * t
end

--[[
-- Clamp a value between a minimum and maximum
-- @param value: the value to clamp
-- @param min: the minimum value
-- @param max: the maximum value
-- -- @return: clamped value
--]]
function Clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    end

    return value
end
