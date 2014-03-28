requires = require '../../../../../requires'

Class       = require('jsclass/src/core').Class

requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
require 'sugar'

BaseParser      = requires.pipe 'parser/base_parser'
TupleBaseParser = requires.pipe 'parser/tuple/tuple_base_parser'

describe 'TupleBaseParser' ->
  var parser, tuple-parser

  create-tuple-parser = (key, value) ->
    new TupleBaseParser key, value

  describe 'initialize(@key, @value)' ->
    describe 'key must be a string' ->
      specify 'key: 0 - fails' ->
        expect(-> new TupleBaseParser 0).to.throw Error

      specify 'key: {} - fails' ->
        expect(-> new TupleBaseParser 0).to.throw Error

      specify 'key: x - ok' ->
        expect(-> new TupleBaseParser 'x').to.not.throw Error

  context 'instance' ->
    before ->
      tuple-parser  := new TupleBaseParser 'x'

    # describe 'list-type' ->
      # @_list-type ||= @calc-list-type!
