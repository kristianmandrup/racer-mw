Class  = require('jsclass/src/core').Class

requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

CollectionPipe  = requires.apipe 'collection'

describe 'PipeValue' ->
  var pipe, obj, result, raw, raw-contained, parser, users

  context 'CollectionPipe' ->
    before ->
      pipe := new CollectionPipe 'users'

    describe 'set-value' ->
      before ->
        obj :=
          * name: 'kris'
            email: 'km@gmail.com'
          ...

        result := pipe.set-value obj


      specify 'result is value that was set' ->
        expect(result).to.eql [{name: 'kris', email: 'km@gmail.com' }]

