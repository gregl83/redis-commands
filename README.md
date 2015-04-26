# redis-commands

Redis provides a lot of functionality for data types "out of the box." Additional functions can be written in the using Lua scripts
for cases where there isn't a "vanilla" function that fits. Redis also uses the Lua interpreter to execute it's native commands. Scripts
are executed atomically (blocking).

For more information on executing Lua scripts with Redis see the [Eval Command Documentation](http://redis.io/commands/eval).

Performance is an important consideration when designing software around a data store. Redis has been built as a high performance data store. When
introducing any IO calls into software it's very important to understand the cost of that functionality. Redis documentation includes a *Time complexity* 
factor for each native command so an evaluation can be performed when deciding which commands and data type should be used to solve a problem. Introducing 
custom functionality or commands should be done so with an equal understanding of their cost. Redis Lua scripts are atomically executed so other commands
cannot execute until the script has finished executing. Redis provides a benchmark tool *redis-benchmark* that has been used to test all the commands in 
this package.

For more information on Redis benchmarks see the [Benchmarks Documentation](http://redis.io/topics/benchmarks).

## Commands

### Priority Lists

Custom Redis data type that is comprised of a keyspace of lists that are ordered by priority. Priority lists are native Redis Lists with all the 
standard [List Commands](http://redis.io/commands#list).

#### PLPUSH key priority value [value ...]

Insert all the specified values at the head of the list stored at key:priority. If key:priority does not exist, it is created as an empty list before performing 
the push operations. When key:priority holds a value that is not a list, an error is returned.

It is possible to push multiple elements using a single command call just specifying multiple arguments at the end of the command. Elements are inserted 
one after the other to the head of the list, from the leftmost element to the rightmost element. So for instance the command PLPUSH mylist high a b c will result 
into a list containing c as first element, b as second element and a as third element.

**Time complexity**

O(1)

**Return values**

[Integer reply](http://redis.io/topics/protocol#integer-reply): the length of the list after the push operations.

**Examples**

```
> redis-cli script load "$(cat /path/to/redis-commands/src/plpush.lua)"
"da39a3ee5e6b4b0d3255bfef95601890afd80709"
redis> EVALSHA da39a3ee5e6b4b0d3255bfef95601890afd80709 2 mylist high "hello"
(integer) 1
redis> EVALSHA da39a3ee5e6b4b0d3255bfef95601890afd80709 2 mylist high "world"
(integer) 1
redis> LRANGE mylist:high 0 -1
1) "hello"
2) "world"
```

#### PRPOPLPUSH source destination priorityList [priorityList ...]

todo

**Time complexity**

O(1 * N) where N is the number of priority lists to try by the operation.

**Return values**

[Bulk string reply](http://redis.io/topics/protocol#bulk-string-reply): the element being popped and pushed.

**Examples**

todo

### Sorted Sets

Native Redis data type. [Sorted Set Commands](http://redis.io/commands#sorted_set).

#### ZLPOPRPUSH source destination

Atomically returns and removes the first element (head) of the sorted set stored at source, and pushes the element at the last element (tail) of the sorted set stored 
at destination. Sorted Set rules still apply.

For example: consider source holding the sorted set a 1, b 2, c 3, and destination holding the sorted set x 4, y 5, z 6. Executing ZLPOPRPUSH results in source holding b 2, c 3 and destination 
holding a 1, x 4, y 5, z 6.

If source does not exist, the value nil is returned and no operation is performed. If source and destination are the same, the operation is equivalent to 
removing the first element from the sorted set and pushing it as last element of the sorted set, so it can be considered as a sorted set rotation command.

**Time complexity**

(coming) early testing revealed that when compared to the O(1) RPOPLPUSH List function with 10M member sets requests per second was reduced by 66%

**Return value**

[Array reply](http://redis.io/topics/protocol#array-reply): element popped and pushed with score.

**Examples**

```
> redis-cli script load "$(cat /path/to/redis-commands/src/zlpoprpush.lua)"
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