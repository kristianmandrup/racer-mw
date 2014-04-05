Class  = require('jsclass/src/core').Class
get    = require '../../../../../requires' .get!
expect = require('chai').expect
get.test 'test_setup'

_ = require 'prelude-ls'

CleanSlate        = get.base-module 'clean_slate'
PipeIdentifier    = get.base-module 'identifier'
PipeNameHelper    = get.base-helper 'name'

BasicPipe = new Class(
  include:
    * PipeIdentifier
    * CleanSlate
    ...

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
      specify 'returns new name' ->
        expect(pipe.set-name 'jake').to.eq 'jake'

      specify 'sets name' ->
        pipe.set-name 'jake'
        expect(pipe.name).to.eq 'jake'

    describe 'name-helper' ->
      specify 'is a PipeNameHelper' ->
        expect(pipe.name-helper!).to.be.an.instance-of PipeNameHelper

      specify 'which has acces to the pipe' ->
        expect(pipe.name-helper!.pipe).to.eq pipe

    context 'parent name: returns my-parent' ->
      before ->
        pipe.parent-name = ->
          'my-parent'

      describe 'update-name' ->
        specify 'only adds parent name' ->
          pipe.update-full-name!
          expect(pipe.full-name).to.eq 'my-parent.jake'

      describe 'set-name' ->
        specify 'sets full name' ->
          pipe.set-name 'bill'
          expect(pipe.full-name).to.eq 'my-parent.bill'
