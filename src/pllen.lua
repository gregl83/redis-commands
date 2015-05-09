local result = {}
local insert = table.insert
local pairs = pairs
local rcall = redis.call

for key, val in pairs(ARGV) do
    local source = KEYS[1] .. ':' .. val
    insert(result, val)
    insert(result, rcall('llen', source))
end

return result