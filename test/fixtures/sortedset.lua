local rcall = redis.call
local results = {}


for member=0, ARG[1], 1 do
    rcall('zadd', KEY[1], member)
end
results[KEY[1]] = member

for member=member, ARG[2], 1 do
    rcall('zadd', KEY[1], member)
end
results[KEY[2]] = member - results[KEY[1]]

return results