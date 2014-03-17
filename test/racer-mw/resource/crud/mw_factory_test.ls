Class    = require('jsclass/src/core').Class
requires = require '../../../../requires'

requires.test 'test_setup'

MwFactory = requires.resource 'crud/mw_factory'

_  = require 'prelude-ls'
require 'sugar'

expect = require('chai').expect

util = require 'util'

describe 'MwFactory' ->
  var factory

  describe 'init' ->
    specify 'no args fails' ->
      expect(-> new MwFactory).to.throw Error

    specify 'invalid arg: 1 fails' ->
      expect(-> new MwFactory 1).to.throw Error

    specify 'invalid arg: unknown fails' ->
      expect(-> new MwFactory 'unknwon').to.throw Error

    specify 'valid arg: read  ok :)' ->
      expect(-> new MwFactory 'read').to.throw Error

  xcontext 'read action' ->
    before ->
      factory := new MwFactory
      # console.log util.inspect factory

    describe 'x' ->
      specify 'x' ->
        expect(factory.x).to.equal 'x'

