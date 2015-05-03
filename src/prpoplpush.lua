local result
local rcall = redis.call
local i = 1

while not result and ARGV[i] do
    local source = KEYS[1] .. ':' .. ARGV[i]
    local destination = KEYS[2] .. ':' .. ARGV[i]
    result = rcall('rpoplpush', source, destination)
    i = i + 1
end

return result