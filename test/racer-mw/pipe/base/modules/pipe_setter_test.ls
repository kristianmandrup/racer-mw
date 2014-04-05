Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

PipeSetter = get.base-module 'setter'

PipeWithSetter = new Class(
  include: PipeSetter

  initialize: ->
    @
)

describe 'PipeSetter' ->
  var pipe

  describe 'initialize(...@args)' ->
    # @set-all!

  context 'instance' ->
    before ->
      pipe := new PipeWithSetter

    # basic set functionality
    # if pipe has no name, just leave set-name function empty
    describe 'set-all' ->
      # @set-name!
      # @set-value!
      before ->
        pipe.set-all!

      # TODO: use sinon!
      specify 'set-name called' ->
        # expect(pipe.set-name).was.called

      specify 'set-value called' ->
        # expect(pipe.set-value).was.called

    describe 'set-name' ->
      specify 'no change' ->
        expect(pipe.name).to.eql 'kris'

    set-value: ->
      specify 'no change' ->
        expect(pipe.name).to.eql 'kris'
