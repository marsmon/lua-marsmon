-- @Date    : 2024-05-15 10:02:57
-- @Author  : mars
-- @Desc    : Rect Fast版

local RectFast = {}

local rf = { __index = RectFast }

function RectFast.new(x, y, width, height)
    return setmetatable({ x = x, y = y, width = width, height = height }, rf)
end

function RectFast:ContainsXY(x, y)
    return x > self.x and x < self.x + self.width and y > self.y and y <= self.y + self.height
end

function RectFast:SetXY(x,  y)
    self.x = x
    self.y = y
end

function RectFast:Set(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function RectFast:GetMinMaxXY()
    return self.x, self.x + self.width, self.y, self.y + self.height
end

return RectFast
