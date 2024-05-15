local Deque = {}

Deque.__index = function(t,k)
    return rawget(Deque, k)
end

function Deque.new()
    return setmetatable({ _front = 1, _back = 0 }, Deque)
end

function Deque:isEmpty()
    return self._front > self._back
end

function Deque:front()
    return self[self._front]
end

function Deque:back()
    return self[self._back]
end

function Deque:pushFront(value)
    self._front = self._front - 1
    self[self._front] = value
end

function Deque:popFront()
    if self._front <= self._back then
        local result = self[self._front]
        self[self._front] = nil
        self._front = self._front + 1
        return result
    end
end

function Deque:pushBack(value)
    self._back = self._back + 1
    self[self._back] = value
end

function Deque:backIndex()
    return self._back
end

function Deque:frontIndex()
    return self._front
end

function Deque:popBack()
    if self._front <= self._back then
        local result = self[self._back]
        self[self._back] = nil
        self._back = self._back - 1
        return result
    end
end

return Deque