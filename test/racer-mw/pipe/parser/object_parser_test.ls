requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

BaseParser  = requires.pipe   'parser/base_parser'

util = require 'util'

PipeParser = requires.pipe 'pipe_parser'

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

  describe 'parse(obj)' ->

  describe 'parse-single(key, value)' ->

  describe 'list-type(key, value)' ->

  describe 'parse-path(key, value)' ->

  describe 'parse-tupel(key, value)' ->

  describe 'tupel-type(key)' ->