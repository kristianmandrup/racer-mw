requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

ObjectParser    = requires.pipe   'parser/object_parser'

util = require 'util'

PipeParser      = requires.pipe 'pipe_parser'
PathPipe        = requires.apipe 'path'

describe 'BaseParser' ->
  var pipe-parser, parser

  describe 'initialize(parser)' ->
    before ->
      pipe-parser := new PipeParser

    specify 'no arg' ->
      expect(-> new ObjectParser).to.throw Error

    specify 'not a parser' ->
      expect(-> new ObjectParser 'x').to.throw Error

    specify 'parser is a PipeParser' ->
      expect(pipe-parser).to.be.an.instance-of PipeParser

    specify 'arg: PipeParser - ok' ->
      expect(-> new ObjectParser pipe-parser).to.not.throw Error

  context 'instance' ->
    before ->
      pipe-parser   := new PipeParser
      parser        := new ObjectParser pipe-parser

    describe 'parse(obj)' ->

    describe 'parse-single(key, value)' ->
      specify 'no arg: fails' ->
        expect(-> parser.parse-single!).to.throw

      specify 'one arg: fails' ->
        expect(-> parser.parse-single 'x').to.throw

      specify 'one arg: user - ok' ->
        expect(-> parser.parse-single 'user').to.not.throw

    describe 'list-type(key, value)' ->
      specify 'empty list: empty' ->
        expect(parser.list-type('x')).to.eql 'empty'

      specify 'empty list: empty' ->
        expect(parser.list-type('x', [])).to.eql 'empty'

      specify 'obj list: collection' ->
        expect(parser.list-type('x', [{x: 1}])).to.eql 'collection'

      specify 'primitive list: array' ->
        expect(parser.list-type('x', [1,2,3])).to.eql 'array'

      specify 'mixed list: mixed' ->
        expect(parser.list-type('x', [1,2,{x: 3}])).to.eql 'mixed'

    describe 'parse-path(key, value)' ->
      before ->
        parser.debug!

      specify 'no arg: fails' ->
        expect(-> parser.parse-path!).to.throw

      specify '_page: PathPipe' ->
        expect(parser.parse-path '_page').to.be.an.instance-of PathPipe

      specify '_page: x - fails' ->
        expect(-> parser.parse-path '_page', 'x').to.throw

      specify '_page: object - ok' ->
        expect(parser.parse-path '_page', {x: 1}).to.be.an.instance-of PathPipe

    describe 'tupel-type(key)' ->
      specify 'no arg: fails' ->
        expect(-> parser.tupel-type!).to.throw

      specify 'number: fails' ->
        expect(-> parser.tupel-type 3).to.throw

      specify '_users: path' ->
        expect(parser.tupel-type '_users').to.eql 'Path'

      specify '$users: path' ->
        expect(parser.tupel-type '$users').to.eql 'Path'

      specify 'users: plural' ->
        expect(parser.tupel-type 'users').to.eql 'Plural'

      specify 'user: single' ->
        expect(parser.tupel-type 'user').to.eql 'Single'

      specify 'xyz: fails' ->
        expect(-> parser.tupel-type 'xyz').to.throw

    describe 'parse-tupel(key, value)' ->
      specify 'no arg: fails' ->
        expect(-> parser.parse-tupel!).to.throw

      specify 'number: fails' ->
        expect(-> parser.parse-tupel 3).to.throw

      specify 'xyz: fails' ->
        expect(-> parser.parse-tupel 'xyz').to.throw