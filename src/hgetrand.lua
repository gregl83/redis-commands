local result
local rcall = redis.call

math.randomseed(tonumber(tostring({}):match('0x(.*)$'),16))

local fields = rcall('hkeys', KEYS[1])

if nil ~= next(fields) then
    local field = fields[math.random(#fields)]
    result = rcall('hget', KEYS[1], field)
end

return result