local M = {}

--- Picks and removes a random element from an array
---@param array table
---@return any?
function M.pick_random(array)
    if #array == 0 then
        return nil
    end

    local index = math.random(1, #array)
    local elem = table.remove(array, index)

    return elem
end

return M
