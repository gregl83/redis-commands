var should = require('should');
var mockery = require('mockery');
var sinon = require('sinon');


mockery.enable({
  useCleanCache: false,
  warnOnReplace: false,
  warnOnUnregistered: false
});

var child_process = {
    execSync: sinon.stub()
};

mockery.registerMock('child_process', child_process);


var redisCommands = require('../../');


describe('commands', function() {
  after(function() {
    mockery.deregisterAll();
  });

  afterEach(function() {
    child_process.execSync.reset();
  });

  it('get SHA', function(done) {
    var command = 'plpush';
    var commandSHA = 'abcdefghijklmnopqrstuvwxyz0123456789abcd';

    child_process.execSync.returns(commandSHA + "\n");

    var result = redisCommands(command);

    (result).should.be.eql(commandSHA);

    done();
  });

  it('invalid command', function(done) {
    var command = 'invalid';

    should.throws(function() {
      redisCommands(command);
    });

    done();
  });

  it('invalid execSync response', function(done) {
    var command = 'plpush';

    child_process.execSync.returns('invalid response');

    should.throws(function() {
      redisCommands(command);
    });

    done();
  });
});