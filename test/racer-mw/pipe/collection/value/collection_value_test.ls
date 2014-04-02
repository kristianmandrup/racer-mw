Class  = require('jsclass/src/core').Class

requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

CollectionPipe  = requires.apipe 'collection'

util = require 'util'

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

        console.log 'before:', pipe.describe true
        result := pipe.set-value obj
        console.log 'after:', pipe.describe true

        console.log 'Pipe value', pipe.value!
        console.log 'Pipe Raw value', pipe.raw-value!
        console.log 'Pipe 0', util.inspect pipe.get(0).describe(true)
        console.log 'Pipe 0 Raw value', pipe.get(0).raw-value!


      specify 'result is value that was set' ->
        expect(result).to.eql [{name: 'kris', email: 'km@gmail.com' }]

