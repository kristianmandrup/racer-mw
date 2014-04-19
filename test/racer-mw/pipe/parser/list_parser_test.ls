requires    = require '../../../../requires'
requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
PipeParser  = requires.pipe 'pipe_parser'

ListParser  = requires.pipe   'parser/list_parser'

CollectionPipe = requires.apipe 'collection'

describe 'ListParser' ->
  var pipe-parser, parser

  describe 'initialize(parser)' ->
    before ->
      pipe-parser   := new PipeParser

    specify 'no arg' ->
      expect(-> new ListParser).to.throw Error

    specify 'not a parser' ->
      expect(-> new ListParser 'x').to.throw Error

    specify 'parser is a PipeParser' ->
      expect(pipe-parser).to.be.an.instance-of PipeParser

    specify 'PipeParser ok' ->
      expect(-> new ListParser pipe-parser).to.not.throw Error

  context 'instance' ->
    before ->
      pipe-parser   := new PipeParser
      parser        := new ListParser pipe-parser

    describe 'parse(list)' ->
      specify 'parses ok' ->
        expect(-> parser.parse).to.not.throw Error

      specify 'returns parsed - not void' ->
        expect(parser.parse).to.not.be.undefined

    # @parent-type! is 'Collection'
    describe 'inside-collection' ->
      var col-pipe

      specify 'parent not a Collection: false' ->
        expect(parser.inside-collection!).to.be.false

      context 'in collection' ->
        before ->
          parser        := new ListParser pipe-parser
          col-pipe      := new CollectionPipe 'users'
          parser.parent = col-pipe

        specify 'parsed into a Collection pipe' ->
          expect(parser.inside-collection!).to.be.true

    # collection or simple array
    describe.only 'parse-plural(key, value)' ->
      specify 'empty list: fails' ->
        expect(-> parser.parse-plural('x', [])).to.throw

      specify 'mixed list: mixed' ->
        expect(-> parser.parse-plural('x', [1,2,{x: 3}])).to.throw

      specify 'obj list: collection' ->
        expect(parser.parse-plural('x', [{x: 1}])).to.be.an.instance-of CollectionPipe

    describe 'parse-collection(key, value = [])' ->
      specify 'parsed into a Collection pipe' ->
        expect(parser.parse-collection 'users', [{name: 'kris'}]).to.be.an.instance-of CollectionPipe

    describe 'parse-setter(key, value)' ->
      specify 'string not parsed' ->
        expect(-> parser.parse-array 'name').to.throw

      specify 'string not parsed without key' ->
        expect(-> parser.parse-array ['x', 'y']).to.throw

    describe 'parse-obj(obj)' ->
      specify 'no arg: fails' ->
        expect(-> parser.parse-obj!).to.throw

      specify 'number: fails' ->
        expect(-> parser.parse-obj 3).to.throw
