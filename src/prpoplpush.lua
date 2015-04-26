local result
local pairs = pairs
local rcall = redis.call
local priorityLists = {'critical', 'high', 'medium', 'low'}

for key, val in pairs(priorityLists) do
    if not result then
        local source = KEYS[1] .. ':' .. val
        local destination = KEYS[2] .. ':' .. val
        result = rcall('rpoplpush', source, destination)
    end
end

return result