local result
local pairs = pairs
local rcall = redis.call

for key, val in pairs(ARGV) do
    if not result then
        local source = KEYS[1] .. ':' .. val
        local destination = KEYS[2] .. ':' .. val
        result = rcall('rpoplpush', source, destination)
    end
end

return result