requires = require '../../../../../requires'

Class       = require('jsclass/src/core').Class

requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
require 'sugar'

TupleBaseParser = requires.pipe 'parser/tuple/tuple_base_parser'

describe 'TupleBaseParser' ->
  var parser

  create-parser = (key, value) ->
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
      parser := new TupleBaseParser 'x'

    # test if value is list of Object or list of simple types
    # if mixed, throw error
    describe 'list-type' ->
      # @_list-type ||= @calc-list-type!

    describe 'build(name, key, value)' ->
      # value ||= @value; key ||= @key
      # @build name, key, value

    # protected

    describe 'calc-list-type' ->
      # @validate-array "plural value #{@key}"
      # @is-empty! or @is-collection! or @is-array! or 'mixed'

    describe 'is-empty' ->
      # 'empty' if @value.length is 0

    describe 'is-collection' ->
      # 'collection' if @all-are 'Object'

    describe 'is-array' ->
      # 'array' if @all-are @primitive-types!

    describe 'all-are(types)' ->
      # @value.every (item) ->
      #   typeof! item in [types].flatten!
      context 'value: String list' ->
        before ->
          parser := create-parser 'x', ['a', 'b']

        specify 'are all string' ->
          expect(parser.all-are 'String').to.be.ok

        specify 'are all number' ->
          expect(parser.all-are 'Number').to.be.false

      context 'value: String and Number list' ->
        before ->
          parser := create-parser 'x', ['a', 3, 'b']

        specify 'are all string' ->
          expect(parser.all-are parser.primitive-types).to.be.ok

    describe 'primitive-types' ->
      # * \String
      # * \Number

      specify 'has String and Number' ->
        expect(parser.primitive-types).to.include 'String', 'Number'

    describe 'validate-array(msg)' ->
      # unless typeof! @value is 'Array'
        # throw new Error "#{msg} must be an Array, was: #{typeof! @value} #{util.inspect @value}"
      context 'no value' ->
        before ->
          parser := create-parser 'z'

        specify 'throws' ->
          expect(-> parser.validate-array!).to.throw Error

      context 'Object value: {}' ->
        before ->
          parser := create-parser 'x', {}

        specify 'throws' ->
          expect(-> parser.validate-array!).to.throw Error

      context 'String value: y' ->
        before ->
          parser := create-parser 'x', 'y'

        specify 'throws' ->
          expect(-> parser.validate-array!).to.throw Error

      context 'Array value: []' ->
        before ->
          parser := create-parser 'x', []

        specify 'throws' ->
          expect(-> parser.validate-array!).to.not.throw Error
