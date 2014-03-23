requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeParser         = requires.pipe 'pipe_parser'
ParserPipeBuilder  = requires.pipe 'parser/parser_pipe_builder'

util = require 'util'

describe 'ParserPipeBuilder' ->
  var parser, builder

  describe 'initialize: (parser, value)' ->
    specify 'missing Parser: fails' ->
      expect(-> new ParserPipeBuilder 'x', 'y').to.throw Error

    specify 'missing Parser: fails' ->
      parser = new PipeParser
      expect(-> new ParserPipeBuilder parser, 'y').to.not.throw Error


  context 'instance' ->
    before ->
      parser  := new PipeParser
      builder := new ParserPipeBuilder parser, 'y'

    describe 'parsed-builder: (type)' ->

      # arg is usually a string key
    describe 'build: (type, arg)' ->
      specify 'build model' ->
        expect(builder.build 'model').to.be.an.instance-of Object
