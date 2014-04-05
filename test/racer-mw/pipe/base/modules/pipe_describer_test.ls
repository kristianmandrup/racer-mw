Class   = require('jsclass/src/core').Class
get     = require '../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

_ = require 'prelude-ls'

CleanSlate    = get.base-module 'clean_slate'
PipeDescriber = get.base-module 'describer'

# See pipe_child_describer_test

InfoPipe = new Class(
  include:
    * PipeDescriber
    * CleanSlate
    ...

  initialize: ->
    @

  child-hash: {}

  child-names: ->
    []

  type: 'Pipe'
  pipe:
    type: 'Path'
)

ValuePipe = new Class(
  include:
    * PipeDescriber
    * CleanSlate
    ...

  initialize: (@name, @val) ->

  value: ->
    @val

  id: ->
    @name

  child-hash: {}

  child-names: ->
    []

  type: 'Pipe'
  pipe:
    type: 'Path'
)


describe 'PipeDescriber' ->
  var pipe, obj

  context 'InfoPipe' ->
    before ->
      pipe := new InfoPipe
      # console.log pipe.describe!

    describe 'describe' ->
      specify 'returns pipe description' ->
        expect(pipe.describe!).to.eql { type: 'Path', name: undefined, id: undefined, value: undefined}

  context 'ValuePipe' ->
    before ->
      pipe := new ValuePipe 'kris', 27
      # console.log pipe.describe!

    describe 'describe' ->
      specify 'returns pipe description' ->
        expect(pipe.describe!).to.eql { type: 'Path', name: 'kris', id: 'kris', value: 27}
