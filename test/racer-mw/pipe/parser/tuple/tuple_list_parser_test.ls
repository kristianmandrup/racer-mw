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

  describe 'is-array' ->
    # @list-type! is 'array'

  describe 'is-collection' ->
    # @list-type! in @collection-types

  describe 'collection-types' ->
    # ['collection', 'empty']

  describe 'collection' ->
    # return unless @is-collection!
    # @value ||= []
    # build 'collection'
    xcontext 'value: objects' ->
      before ->
        parser := create-parser 'x', [{x: 2}, {y: 5}]

      specify 'builds attributes' ->
        expect(-> parser.collection!).to.be.an.instance-of CollectionPipe

    context 'value: primitives' ->
      before ->
        parser := create-parser 'x', ['a', 'b']

      specify 'builds attributes' ->
        expect(-> parser.collection!).to.be.undefined

  describe 'array' ->
    # return unless @is-array!
    # @build 'attribute'
    context 'value: objects' ->
      before ->
        parser := create-parser 'x', [{x: 2}, {y: 5}]

      specify 'builds attributes' ->
        expect(-> parser.array!).to.be.undefined

    xcontext 'value: primitives' ->
      before ->
        parser := create-parser 'x', ['a', 'b']

      specify 'builds attributes' ->
        expect(-> parser.array!.first!).to.be.an.instance-of AttributePipe

  describe 'none' ->
    # throw new Error "Unable to determine if plural: #{@key} is a collection or array, was: #{@list-type!}"
    specify 'throws' ->
      expect(-> parser.none!).to.throw Error


  describe 'build(name)' ->
    # @validate-array!; @call-super!