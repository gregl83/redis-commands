local result
local rcall = redis.call

local source = KEYS[1] .. ':' .. KEYS[3]

result = rcall('lrem', source, ARGV[1], ARGV[2])

if result then
    local destination = KEYS[2] .. ':' .. KEYS[3]
    for i = 1, result, 1 do
        rcall('lpush', destination, ARGV[2])
    end
end

return result