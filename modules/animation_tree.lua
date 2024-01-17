local xvmath = require("modules.xvmath")

local AnimationTree = {}

---@class AnimationTree
---@field current_animation string|nil
---@field current_blenspace string|nil
---@field blendspaces table<string, Blendspace>
---@field blendspace fun(self: AnimationTree, name: string, animations: table<integer, BlendspaceAnimation>): nil
---@field play fun(self: AnimationTree, name: string): nil
---@field update fun(self: AnimationTree, value: vector, callback: fun(name: string)): nil

---@class Blendspace
---@field name string
---@field animations table<integer, BlendspaceAnimation>

---@class BlendspaceAnimation
---@field animation string
---@field value vector3

---@return AnimationTree
function AnimationTree.new()
    local state = {
        current_animation = nil,
        current_blenspace = nil,
        last_value = xvmath.zero(),
        blendspaces = {},
    }
    return setmetatable(state, { __index = AnimationTree })
end

---Add a blend space
---@param name string
---@param animations table<integer, BlendspaceAnimation>
function AnimationTree:blendspace(name, animations)
    self.blendspaces[name] = animations
end

---Set current animation
---@param name any
function AnimationTree:play(name)
    self.current_blenspace = name
end

---Update blend position
---@param value vector3
function AnimationTree:update(value, on_animation_changed)
    local closest_anim = nil
    local min_dist = 99999999

    if value == xvmath.zero() then
        value = self.last_value
    end

    for _, animation in ipairs(self.blendspaces[self.current_blenspace]) do
        local dist = xvmath.distance(value, animation.value)

        if dist < min_dist then
            min_dist = dist
            closest_anim = animation.animation
        end
    end

    if not closest_anim then
        return
    end

    if on_animation_changed and closest_anim ~= self.current_animation then
        self.last_value = value
        self.current_animation = closest_anim
        on_animation_changed(closest_anim)
    end
end

return AnimationTree
