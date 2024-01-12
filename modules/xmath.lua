local M = {}

M.CMP_EPSILON = 0.00001

---@param value number
---@param min number
---@param max number
---@return number
function M.clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

return M
