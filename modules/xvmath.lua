local xmath = require("modules.xmath")

local M = {}

---@return vector3
function M.up()
    return vmath.vector3(0, 1, 0)
end

---@return vector3
function M.down()
    return vmath.vector3(0, -1, 0)
end

---@return vector3
function M.left()
    return vmath.vector3(-1, 0, 0)
end

---@return vector3
function M.right()
    return vmath.vector3(1, 0, 0)
end

---@return vector3
function M.zero()
    return vmath.vector3(0, 0, 0)
end

---@param vec vector3
---@param vec_to vector3
---@param dt float
function M.move_toward(vec, vec_to, dt)
    local vd = vec_to - vec
    local length = vmath.length(vd)

    if length <= dt or length < xmath.CMP_EPSILON then
        return vec_to
    else
        return vec + vd / length * dt
    end
end

---@param vec vector3
---@param length number
---@return vector3
function M.limit_length(vec, length)
    local l = vmath.length(vec)
    local v = vec

    if l > 0 and length < l then
        v = (v / l) * length
    end

    return v
end

return M
