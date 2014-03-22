Class  = require('jsclass/src/core').Class

requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

ModelPipe       = requires.apipe   'model'

describe 'PipeValue' ->
  var pipe, obj, result, raw, raw-contained, parser, users

  context 'ModelPipe' ->
    before ->
      pipe := new ModelPipe 'admin'

    describe 'set-value' ->
      before ->
        result := pipe.set-value { name: 'mike', email: 'mike@the.man' }

      specify 'result is value that was set' ->
        expect(result).to.equal { name: 'mike', email: 'mike@the.man' }

