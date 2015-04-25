# redis-commands

Redis provides a lot of functionality for data types "out of the box." Additional functions can be written in the using Lua scripts
for cases where there isn't a "vanilla" function that fits. Redis also uses the Lua interpreter to execute it's native commands. Scripts
are executed atomically (blocking).

For more information on how Lua scripts are executed with Redis see the [Eval Command Documentation](http://redis.io/commands/eval).

Performance is an important consideration when designing software around a data store. Redis has been built as a high performance data store. When
introducing any IO calls into software it's very important to understand the cost of that functionality. Redis documentation includes a *Time complexity* 
factor for each native command so an evaluation can be performed when deciding which commands and data type should be used to solve a problem. Introducing 
custom functionality or commands should be done so with an equal understanding of their cost. Redis Lua scripts are atomically executed so other commands
cannot execute until the script has finished executing. Redis provides a benchmark tool *redis-benchmark* that has been used to test all the commands in 
this package.

For more information on Redis benchmarks see the [Redis Benchmarks Documentation](http://redis.io/topics/benchmarks).

## Commands

### Sorted Sets

#### ZRPOPLPUSH source destination

todo

**Return value**

[Array reply](http://redis.io/topics/protocol#array-reply): element popped and pushed with score.

**Examples**

```
> redis-cli script load "$(cat /path/to/redis-commands/src/zrpoplpush.lua)"
"a34f28bab1fdcd6ca9effe3ce21f797c4873024f"
> redis-cli
redis> ZADD source 1 "one"
(integer) 1
redis> ZADD source 2 "two"
(integer) 1
redis> ZCARD source
(integer) 2
redis> ZCARD destination
(integer) 0
redis> EVALSHA a34f28bab1fdcd6ca9effe3ce21f797c4873024f 2 source destination
1) "one"
2) "1"
redis> EVALSHA a34f28bab1fdcd6ca9effe3ce21f797c4873024f 2 source destination
1) "two"
2) "2"
redis> ZCARD source
(integer) 0
redis> ZCARD destination
(integer) 2
```

## License

MIT