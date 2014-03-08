requires = require '../../../../requires'

requires.test 'test_setup'

expect                  = require('chai').expect

PathPipe                = requires.apipe 'path'
CollectionPipeBuilder   = requires.apipe-builder 'collection'

describe 'CollectionPipeBuilder' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take an object that can attach' ->
        expect(-> new CollectionPipeBuilder).to.throw

  context 'Path pipe' ->
    before ->
      pipe := new PathPipe '_path'

    describe 'init' ->
      specify 'pass pipe - success' ->
        expect(-> new CollectionPipeBuilder pipe).to.not.throw
