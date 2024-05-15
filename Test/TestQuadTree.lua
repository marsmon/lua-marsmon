
package.path = package.path .. ";../?.lua"

local QuadTree = require "../QuadTree"

local qt = QuadTree.new(1, 1, 100, 100)

for i = 1, 100 do
    qt:insert(i, i, i)
end

qt:remove(20)

qt:remove(24, 21, 100)

local result = {}
qt:query(19, 19, 60, 60, result)

for k, v in pairs(result) do
    print("result", 0, v)
end