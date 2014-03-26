requires    = require '../../../../../requires'
requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'

PipeParser  = requires.pipe 'pipe_parser'

ListParser  = requires.pipe   'parser/list_parser'

CollectionPipe = requires.apipe 'collection'

TupleListParser = requires.pipe 'parser/tuple/tuple_list_parser'

describe 'TupleListParser' ->
  var parser

  create-parser = (key, value) ->
    new TupleListParser key, value

  describe 'initialize(@key, @value)' ->
    describe 'key must be a string' ->
      specify 'key: 0 - fails' ->
        expect(-> new TupleListParser 0).to.throw Error

      specify 'key: {} - fails' ->
        expect(-> new TupleListParser 0).to.throw Error

      specify 'key: x - ok' ->
        expect(-> new TupleListParser 'x').to.not.throw Error

  # collection or simple array
  describe 'parse-plural' ->
    # @array! or @collection! or @none!



  describe 'build(name)' ->
    # @validate-array!; @call-super!