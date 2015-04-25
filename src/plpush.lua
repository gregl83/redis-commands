local rcall = redis.call

local key = KEYS[1] .. ':' .. KEYS[2]

return rcall('lpush', key, unpack(ARGV))