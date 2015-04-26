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