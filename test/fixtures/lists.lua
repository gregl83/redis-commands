local tonumber = tonumber
local insert = table.insert
local rcall = redis.call
local results = {}

local member
local argv1 = tonumber(ARGV[1])
local argv2 = tonumber(ARGV[2])

for member = 1, argv1, 1 do
    rcall('rpush', KEYS[1], member)
end
insert(results, KEYS[1])
insert(results, argv1)

local initialValue = argv1 + 1
local endValue = initialValue + argv2
for member = initialValue, endValue, 1 do
    rcall('rpush', KEYS[2], member)
end
insert(results, KEYS[2])
insert(results, argv2)

return results