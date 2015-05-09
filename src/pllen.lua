local result = {}
local insert = table.insert
local rcall = redis.call
local i = 2

while KEYS[i] do
    local source = KEYS[1] .. ':' .. KEYS[i]
    insert(result, KEYS[i])
    insert(result, rcall('llen', source))
    i = i + 1
end

return result