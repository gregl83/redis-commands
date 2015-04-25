local tonumber = tonumber
local random = math.random
local insert = table.insert
local rcall = redis.call
local results = {}

local member
local argv1 = tonumber(ARGV[1])
local argv2 = tonumber(ARGV[2])
local argv3 = tonumber(ARGV[3])

for member = 1, argv1, 1 do
    local score = random(1, argv3)
    rcall('zadd', KEYS[1], score, member)
end
insert(results, KEYS[1])
insert(results, argv1)

local initialValue = argv1 + 1
local endValue = initialValue + argv2
for member = initialValue, endValue, 1 do
    local score = random(1, argv3)
    rcall('zadd', KEYS[2], score, member)
end
insert(results, KEYS[2])
insert(results, argv2)
insert(results, argv3)

return results