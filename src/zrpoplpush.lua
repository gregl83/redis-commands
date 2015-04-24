local result
local next = next
local rcall = redis.call

local member = rcall('zrange', KEYS[1], 0, 0, 'WITHSCORES')
result = member

if nil ~= next(member) then
    rcall('zadd', KEYS[2], member[2], member[1])
    rcall('zremrangebyrank', KEYS[1], 0, 0)
end

return result