local result = {}
local insert = table.insert
local rcall = redis.call
local i = 1

if ARGV[3] ~= nil or ARGV[3] == 0 then
    local members = rcall('zrange', KEYS[1], ARGV[1], ARGV[2])

    while members[i] do
        insert(result, members[i])
        local score = rcall('zincrby', KEYS[1], ARGV[3], members[i])
        if "WITHSCORES" == ARGV[4] then
            insert(result, score)
        end
        i = i + 1
    end
end

return result