Class  = require('jsclass/src/core').Class

requires    = require '../../../../../requires'
requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'

PipeParser            = requires.pipe 'pipe_parser'
ParserChildrenBuilder = requires.pipe 'parser/builder/parser_children_builder'

MockParser = new Class(
  parse: ->
    'mocked!'
)

ModelPipe = requires.apipe 'model'

describe 'ParserChildrenBuilder' ->
  var builder

  describe 'initialize(@parser, @value)' ->
    specify 'no arg - fails' ->
      expect(-> new ParserChildrenBuilder).to.throw Error

    specify 'invalid parser arg - fails' ->
      expect(-> new ParserChildrenBuilder 'x').to.throw Error

    specify 'parser arg - ok' ->
      expect(-> new ParserChildrenBuilder(new MockParser)).to.not.throw Error

  context 'instance' ->
    var parent-pipe

    before ->
      builder := new ParserChildrenBuilder(new MockParser)

    describe 'pipe-parser' ->
      specify 'is created' ->
        expect(builder.pipe-parser!).to.be.an.instance-of PipeParser

    describe 'parsed-pipes' ->
      specify 'no value - fails' ->
        expect(-> builder.parsed-pipes!).to.throw Error

    describe 'parse-value' ->
      specify 'no value - fails' ->
        expect(-> builder.parsed-value!).to.throw Error

    describe 'build(parent-pipe)' ->
      specify 'no parent-pipe - fails' ->
        expect(-> builder.build!).to.throw Error

      specify 'parent-pipe: x - fails' ->
        expect(-> builder.build x).to.throw Error

      context 'parent-pipe: ModelPipe' ->
        before ->
          parent-pipe := new ModelPipe 'user'

        specify 'ok' ->
          expect(-> builder.build parent-pipe).to.not.throw Error

        specify 'returns parent when no value' ->
          expect(builder.build parent-pipe).to.eq parent-pipe

        context 'with value' ->
          specify '-> {x: 2}' ->
            expect(builder.build parent-pipe, {x: 2}).to.not.eq parent-pipe

          xdescribe 'parsed-pipes' ->
            specify 'are created' ->
              expect(-> builder.parsed-pipes!).to.not.throw Error

          xdescribe 'parse-value' ->
            specify 'is parsed and attached' ->
              expect(-> builder.parsed-value!).to.throw Error
