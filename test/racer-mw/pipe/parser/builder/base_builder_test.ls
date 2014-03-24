Class  = require('jsclass/src/core').Class

requires    = require '../../../../../requires'
requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'

PipeParser        = requires.pipe 'pipe_parser'
BaseParser        = requires.pipe 'parser/base_parser'

ParserBaseBuilder = requires.pipe 'parser/builder/parser_base_builder'

MockParser = new Class(
  parse: ->
    'mocked!'
)

ModelPipe = requires.apipe 'model'

describe 'ParserBaseBuilder' ->
  var parser, builder, parent-pipe

  describe 'initialize(value)' ->
    specify 'no args - fails' ->
      expect(-> new ParserBaseBuilder).to.throw Error

    specify 'first arg: NOT a parser - fails' ->
      expect(-> new ParserBaseBuilder 'x').to.throw Error

    specify 'first arg: a parser - ok' ->
      expect(-> new ParserBaseBuilder(new MockParser)).to.not.throw Error

  context 'instance' ->
    before ->
      parser  := new MockParser
      builder := new ParserBaseBuilder parser, 'x'

    describe 'build(arg)' ->
      specify 'must be implemented by subclass - fails' ->
        expect(-> builder.build 'x').to.throw Error

    describe 'build-children(parent)' ->
      before ->
        parent-pipe := new ModelPipe 'user'

      specify 'parent pipe is a ModelPipe' ->
        expect(parent-pipe).to.be.an.instance-of ModelPipe

      specify 'parent not a pipe - fails' ->
        expect(-> builder.build-children 'x').to.throw Error

      specify 'parent pipe - ok' ->
        expect(-> builder.build-children parent-pipe).to.not.throw Error

    describe 'parser-builder' ->
      specify 'creates BaseParser' ->
        expect(builder.parser-builder!).to.be.an.instance-of BaseParser
