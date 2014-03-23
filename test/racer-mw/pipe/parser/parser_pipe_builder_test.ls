requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

ParserPipeBuilder  = requires.pipe   'parser/parser_pipe_builder'

util = require 'util'

describe 'ParserPipeBuilder' ->
  var parser

  describe 'initialize: (parser, value)' ->
    specify 'inits' ->
      expect(-> new ParserPipeBuilder 'x', 'y').to.not.throw Error

  context 'instance' ->
    before ->
      parser := new ParserPipeBuilder 'x', 'y'

    describe 'parsed-builder: (type)' ->

      # arg is usually a string key
    describe 'build: (type, arg)' ->
      specify 'build model' ->
        expect(parser.build 'model').to.be.an.instance-of
