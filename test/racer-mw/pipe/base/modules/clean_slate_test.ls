Class  = require('jsclass/src/core').Class
get = require '../../../../../requires' .get!
get.test 'test_setup'
expect = require('chai').expect

CleanSlate = get.base-module 'clean_slate'

CleanPipe = new Class(
  include: CleanSlate

  initialize: ->
    @call-super!
    @

  pipe:
    type: 'CleanSlate'
)

describe 'Pipe - CleanSlate' ->
  var pipe

  describe 'initialize: any' ->
    specify 'no args - ok' ->
      expect(-> new CleanPipe).to.not.throw Error

  context 'instance' ->
    before ->
      pipe := new CleanPipe

    describe 'allows-child(type): false' ->
      specify 'model: false' ->
        expect(pipe.allows-child 'model').to.be.false

    describe 'parse: (...args): throws' ->
      specify 'any args: throws' ->
        expect(-> pipe.parse 'y').to.throw Error

    describe 'add: (...args)' ->
      specify 'ay args: throws' ->
        expect(-> pipe.add 'x').to.throw Error


    describe 'parent-name' ->
      specify 'is void' ->
        expect(pipe.parent-name!).to.be.undefined
