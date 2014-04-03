Class  = require('jsclass/src/core').Class
get = require '../../../../../requires' .get!
get.test 'test_setup'
expect = require('chai').expect

PipeValidation        = get.base-module 'validation'

ValPipe = new Class(
  include:
    * PipeValidation
    ...

  initialize: ->
    @
)

describe 'PipeValidation module' ->
  var pipe, parent, not-pipe

  describe 'include module' ->
    specify 'works' ->
      expect(-> new ValPipe).to.not.throw Error

  context 'instance' ->
    before ->
      parent    := new ValPipe
      pipe      := new ValPipe parent
      not-pipe  := {}

    describe 'is-pipe(pipe)' ->
      specify 'valid when pipe' ->
        expect(-> pipe.is-valid parent).to.not.throw Error

      specify 'invalid when not a pipe' ->
        expect(-> pipe.is-valid not-pipe).to.throw Error
