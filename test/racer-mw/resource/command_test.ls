Class    = require('jsclass/src/core').Class
requires = require '../../../requires'

requires.test 'test_setup'

requires = require '../../../requires'

ResourceCommand   = requires.resource 'command'

expect        = require('chai').expect

describe 'Command' ->
  var command, resource

  before ->
    resource := {}

  describe 'init' ->
    context 'no args' ->
      specify 'creates it' ->
        expect(-> new ResourceCommand).to.not.throw

    context 'a command' ->
      before ->
        command := new ResourceCommand resource

      specify 'add query method' ->
        expect(command.query).to.be.an.instance-of Function

      specify 'add filter method' ->
        expect(command.filter).to.be.an.instance-of Function
