requires    = require '../../../requires'
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

  describe 'parent-type' ->
    specify 'is from parent' ->
      expect(base-parser.parent-type).to.eql parser.parent.parent-type

  describe 'build(type, value, arg)' ->
    specify 'builds using builder' ->
      expect(-> base-parser.build 'model', {x: 2}, y).to.not.throw Error

  describe 'builder(type)' ->
    specify 'finds builder class' ->
      expect(base-parser.builder 'model').to.not.throw Error

