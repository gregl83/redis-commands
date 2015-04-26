var fs = require('fs');
var path = require('path');
var child_process = require('child_process');

/**
 * Get Redis Command SHA
 *
 * NOTE: Uses ChildProcess.ExecSync requiring NodeJS v0.12 or higher
 *
 * @param {string} command name
 * @returns {string} commandSHA
 * @throws {error}
 * @sync
 */
module.exports = function(command) {
  var commandPath = path.resolve('src/' + command + '.lua');

  var commandSource = fs.readFileSync(commandPath, {encoding: 'utf8'});

  var result = child_process.execSync('redis-cli script load "' + commandSource + '"', {encoding: 'utf8'});

  var commandSHA = result.match(/^([a-z0-9]{40})/g);

  if (null === commandSHA || 'undefined' === typeof commandSHA[0]) throw new Error(command + '.lua invalid SHA');

  return commandSHA[0];
};