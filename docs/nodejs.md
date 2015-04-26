[![Build Status](https://travis-ci.org/gregl83/redis-commands.svg?branch=master)](https://travis-ci.org/gregl83/redis-commands)
[![Coverage Status](https://coveralls.io/repos/gregl83/redis-commands/badge.svg)](https://coveralls.io/r/gregl83/redis-commands?branch=master)
# redis-commands [nodejs]

Redis Commands for NodeJS

## Requirements

- Redis
- NodeJS v0.12.x or higher
- NPM

See `./package.json`

## Installation

    $ npm install n-redis-commands

## Usage

```js
var redisCommands = require('n-redis-commands');

var plpushSHA = redisCommands('plpush');

// use plpushSHA as arg to EVALSHA with supporting Redis Client
```

## License

MIT