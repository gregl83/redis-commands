local result
local rcall = redis.call
local i = 3

while not result and KEYS[i] do
    local source = KEYS[1] .. ':' .. KEYS[i]
    local destination = KEYS[2] .. ':' .. KEYS[i]
    result = rcall('rpoplpush', source, destination)
    i = i + 1
end

return result