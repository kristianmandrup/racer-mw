requires    = require '../../../requires'
requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
PipeParser  = requires.pipe 'pipe_parser'

BaseParser  = requires.pipe   'parser/base_parser'

describe 'ListParser' ->
  var pipe-parser, parser

  describe 'initialize(parser)' ->
    specify 'no arg' ->
      expect(-> new ListParser).to.throw Error

    specify 'not a parser' ->
      expect(-> new ListParser 'x').to.throw Error

    specify.only 'PipeParser ok' ->
      parser = new PipeParser
      expect(-> new ListParser parser).to.not.throw Error

  xcontext 'instance' ->
    before ->
      pipe-parser   := new PipeParser
      parser        := new ListParser parser

    describe 'parse: (list)' ->
      parser.parse

    # @parent-type! is 'Collection'
    xdescribe 'inside-collection' ->
      var col-pipe

      specify 'parsed into a Collection pipe' ->
        expect(parser.inside-collection!).to.be.true

      context 'in collection' ->
        before ->
          parser        := new ListParser parser
          col-pipe      := new CollectionPipe 'users'
          parser.parent = col-pipe

        specify 'parsed into a Collection pipe' ->
          expect(parser.inside-collection!).to.be.true

    # collection or simple array
    describe 'parse-plural(key, value)' ->
      specify 'empty list: fails' ->
        expect(-> parser.parse-plural('x', [])).to.throw

      specify 'mixed list: mixed' ->
        expect(-> parser.parse-plural('x', [1,2,{x: 3}])).to.throw

      specify 'obj list: collection' ->
        expect(parser.parse-plural('x', [{x: 1}])).to.be.an.instance-of CollectionPipe

    describe 'parse-collection(key, value = [])' ->
      specify 'parsed into a Collection pipe' ->
        expect(parser.parse-collection 'users', [{name: 'kris'}]).to.be.an.instance-of CollectionPipe

    describe 'parse-array(key, value)' ->
      specify 'string not parsed' ->
        expect(-> parser.parse-array 'name').to.throw

      specify 'string not parsed without key' ->
        expect(-> parser.parse-array ['x', 'y']).to.throw

    describe 'parse-obj(obj)' ->
      specify 'no arg: fails' ->
        expect(-> parser.parse-obj!).to.throw

      specify 'number: fails' ->
        expect(-> parser.parse-obj 3).to.throw
