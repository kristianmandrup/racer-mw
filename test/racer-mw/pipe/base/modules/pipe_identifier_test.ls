Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

_ = require 'prelude-ls'

PipeIdentifier   = requires.pipe 'pipe_identifier'

BasicPipe = new Class(
  include: PipeIdentifier

  initialize: ->
    @
)

describe 'PipeIdentifier' ->
  var pipe, obj

  context 'Basic pipe' ->
    before ->
      pipe := new BasicPipe

    describe 'id' ->
      specify 'throws error' ->
        expect(-> pipe.id!).to.throw Error

    describe 'set-name' ->
      specify 'sets it' ->
        expect(pipe.set-name 'jake').to.eq 'jake'

    context 'parent name function' ->
      before ->
        pipe.parent-name = ->
          'parent'

      describe 'update-name' ->
        specify 'only adds parent name' ->
          pipe.update-name 'chilly'
          expect(pipe.full-name).to.eq 'parent.jake'

      describe 'set-name' ->
        specify 'sets full name' ->
          pipe.set-name 'bill'
          expect(pipe.full-name).to.eq 'parent.bill'
