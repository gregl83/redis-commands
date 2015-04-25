local tonumber = tonumber
local insert = table.insert
local rcall = redis.call
local results = {}

local member
local key
local argv1 = tonumber(ARGV[1])
local argv2 = tonumber(ARGV[2])
local argv3 = tonumber(ARGV[3])
local argv4 = tonumber(ARGV[4])

key = KEY[1] .. ':critical'
for member = 1, argv1, 1 do
    rcall('rpush', key, member)
end
insert(results, key)
insert(results, argv1)

key = KEY[1] .. ':high'
for member = 1, argv2, 1 do
    rcall('rpush', key, member)
end
insert(results, key)
insert(results, argv2)

key = KEY[1] .. ':medium'
for member = 1, argv3, 1 do
    rcall('rpush', key, member)
end
insert(results, key)
insert(results, argv3)

key = KEY[1] .. ':low'
for member = 1, argv4, 1 do
    rcall('rpush', key, member)
end
insert(results, key)
insert(results, argv4)

return results