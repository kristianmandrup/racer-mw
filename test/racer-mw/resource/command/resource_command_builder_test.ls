Class    = require('jsclass/src/core').Class
requires = require '../../../../requires'

requires.test 'test_setup'

CommandBuilder = requires.resource 'command/resource_command_builder'

_  = require 'prelude-ls'
require 'sugar'

expect = require('chai').expect

empty-obj = {
  commands:
    scope:
      * 'set'

    on-scope:
      * 'get'
}

util = require 'util'

describe 'CommandBuilder' ->
  context 'empty obj' ->
    var builder, built-obj

    before ->
      builder := new CommandBuilder(empty-obj)
      # console.log util.inspect builder

    describe 'init' ->
      specify 'commander set' ->
        expect(builder.commander).to.equal empty-obj

      specify 'command type: scope' ->
        expect(_.keys builder.commands).to.include 'scope'

      specify 'command type: on-scope' ->
        expect(_.keys builder.commands).to.include 'onScope'

    describe 'parse-type' ->
      specify 'on-scope is on' ->
        expect(builder.parse-type 'onScope').to.equal 'on'

      specify 'scope is void (default)' ->
        expect(builder.parse-type 'scope').to.be.unknown

    describe 'build' ->
      before ->
        built-obj := builder.build!
        # console.log 'built', util.inspect built-obj

      specify 'add on-methods' ->
        expect(built-obj.get).to.be.an.instance-of Function

      specify 'add set-methods' ->
        expect(built-obj.set).to.be.an.instance-of Function

