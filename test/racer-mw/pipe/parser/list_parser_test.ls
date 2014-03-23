requires    = require '../../../requires'
requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
PipeParser  = requires.pipe 'pipe_parser'

BaseParser  = requires.pipe   'parser/base_parser'

describe 'ListParser' ->
  var parser, list-parser

  describe 'initialize(parser)' ->
    specify 'no arg' ->
      expect(-> new ListParser).to.throw Error

    specify 'not a parser' ->
      expect(-> new ListParser 'x').to.throw Error

    specify 'PipeParser ok' ->
      parser = new PipeParser
      expect(-> new ListParser parser).to.not.throw Error

  context 'instance' ->
    before ->
      parser      := new PipeParser
      list-parser := new ListParser parser


    describe 'parse: (list)' ->

    describe 'inside-collection' ->

    # collection or simple array
    describe 'parse-plural(key, value)' ->

    describe 'parse-collection(key, value = [])' ->

    describe 'parse-array(key, value)' ->

    describe 'parse-obj(obj)' ->

