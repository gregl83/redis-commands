local result = {}
local insert = table.insert
local remove = table.remove
local rcall = redis.call

math.randomseed(tonumber(tostring({}):match('0x(.*)$'),16))

local fields = rcall('hkeys', KEYS[1])

for i=1, ARGV[1], 1 do
    if nil ~= next(fields) then
        local field = remove(fields, math.random(#fields))
        local value = rcall('hget', KEYS[1], field)
        insert(result, value)
    end
end

return result