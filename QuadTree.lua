-- @Date    : 2024-05-15 14:01:48
-- @Author  : mars
-- @Desc    : 四叉树

local QuadTree = {}

local MaxObjectPerQuad = 2

local qt = { __index = QuadTree }

--[[
    left < right
    top < bottom
]]
function QuadTree.new(left, top, right, bottom)
    return setmetatable({
        left = left,
        top = top,
        right = right,
        bottom = bottom,
        objects = {},
    }, qt)
end

function QuadTree:insert(id, x, y)
    if x < self.left or x > self.right or y < self.top or y > self.bottom then
        return
    end

    if self.children then
        local t
        for _, v in pairs(self.children) do
            t = v:insert(id, x, y)
            if t then return t end
        end
    else
        self.objects[id] = { x = x, y = y }

        if #self.objects >= MaxObjectPerQuad then
            return self:subdivide(id)
        end

        return self
    end
end

function QuadTree:subdivide(last)
    local left, top, right, bottom = self.left, self.top, self.right, self.bottom
    local centerx = (left + right) // 2
    local centery = (top + bottom) // 2

    self.children = {
        QuadTree.new(left, top, centerx, centery),
        QuadTree.new(centerx, top, right, centery),
        QuadTree.new(left, centery, centerx, bottom),
        QuadTree.new(centerx, centery, right, bottom),
    }

    local ret
    local t
    for k, v in pairs(self.objects) do
        for _, c in pairs(self.children) do
            t = c:insert(k, v.x, v.y)
            if t then
                if k == last then
                    ret = t
                end
                break
            end
        end
    end
    self.objects = nil

    return ret
end

function QuadTree:remove(id)
    if self.objects then
        if self.objects[id] ~= nil then
            self.objects[id] = nil
            return true
        end
    elseif self.children then
        for _, v in pairs(self.children) do
            if v:remove(id) then return true end
        end
    end
end

function QuadTree:removeByXY(id, x, y)
    if self.objects then
        if self.objects[id] ~= nil then
            self.objects[id] = nil
            return true
        end
    elseif self.children then
        for _, v in pairs(self.children) do
            if not (x < v.left or x > v.right or y < v.top or y > v.bottom) then
                if v:removeByXY(id, x, y) then return true end
            end
        end
    end
end

function QuadTree:query(left, top, right, bottom, result)
    if left > self.right or right < self.left or top > self.bottom or bottom < self.top then
        return
    end

    if self.children then
        for _, v in pairs(self.children) do
            v:query(left, top, right, bottom, result)
        end
    else
        for k, v in pairs(self.objects) do
            if v.x > left and v.x < right and v.y > top and v.y < bottom then
                table.insert(result, k)
            end
        end
    end
end

return QuadTree