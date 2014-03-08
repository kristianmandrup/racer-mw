requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeNavigator   = requires.pipe   'navigator'
ModelPipe       = requires.apipe  'model'

describe 'PipeNavigator' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new PipeNavigator).to.throw

    context 'model pipe' ->
      before ->
        pipe := new ModelPipe {_clazz: 'user'}

      specify 'created' ->
        expect(-> new PipeNavigator pipe).to.not.throw




