requires    = require '../../../../requires'
requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'

PipeParser  = requires.pipe 'pipe_parser'
BaseParser  = requires.pipe   'parser/base_parser'

describe 'BaseParser' ->
  var parser, base-parser

  describe 'initialize(parser)' ->
    specify 'no arg' ->
      expect(-> new BaseParser).to.throw Error

    specify 'not a parser' ->
      expect(-> new BaseParser 'x').to.throw Error

    specify 'PipeParser ok' ->
      parser = new PipeParser
      expect(-> new BaseParser parser).to.not.throw Error

  context 'instance' ->
    before ->
      parser      := new PipeParser
      base-parser := new BaseParser parser

    specify 'is a BaseParser' ->
      expect(base-parser).to.be.an.instance-of BaseParser

    specify 'parser is a PipeParser' ->
      expect(parser).to.be.an.instance-of PipeParser

    describe 'parent-type' ->
      specify 'same as parent' ->
        expect(base-parser.parent-type!).to.eql parser.parent-type!

    describe 'builder-clazz(type)' ->
      specify 'builder class: model - ok' ->
        expect(base-parser.builder-clazz 'model').to.not.be.undefined

      specify 'builder class: unknown - fails' ->
        expect(-> base-parser.builder-clazz 'unknown').to.throw Error

    describe 'create-builder(type)' ->
      specify 'builder class: model - created' ->
        expect(base-parser.create-builder 'model').to.not.be.undefined

    describe 'build(type, value, arg)' ->
      var parent-pipe
      before ->
        parent-pipe := new ModelPipe 'user'

      specify 'builds model using builder' ->
        expect(-> base-parser.build 'model', {x: 2}).to.not.throw Error

      specify 'builds children using builder' ->
        expect(-> base-parser.build 'children', parent-pipe).to.not.throw Error
