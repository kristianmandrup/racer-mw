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

    # describe 'list-type' ->
      # @_list-type ||= @calc-list-type!

    xdescribe 'build(name, key, value)' ->
      # value ||= @value; key ||= @key
      # @build name, key, value
      specify 'collection: users' ->
        expect(parser.build 'collection', 'users').to.not.throw Error

      specify 'model: user' ->
        expect(parser.build 'model', 'user').to.not.throw Error

    # protected

    describe 'calc-list-type' ->
      # @validate-array "plural value #{@key}"
      # @is-empty! or @is-collection! or @is-array! or 'mixed'
      context 'value: Object list' ->
        before ->
          parser := create-parser 'x', [{x: 2}, {y: 5}]

        specify 'is a collection' ->
          expect(parser.calc-list-type!).to.eql 'collection'

      context 'value: String list' ->
        before ->
          parser := create-parser 'x', ['a', 'b']

        specify 'is an array' ->
          expect(parser.calc-list-type!).to.eql 'array'

      context 'value: Mixed list' ->
        before ->
          parser := create-parser 'x', ['a', {x:2}, 'b']

        specify 'is mixed' ->
          expect(parser.calc-list-type!).to.eql 'mixed'

    describe 'is-empty' ->
      # 'empty' if not @value or @value.length is 0
      context 'value: void' ->
        before ->
          parser := create-parser 'x'

        specify 'is empty' ->
          expect(parser.is-empty!).to.be.ok

      context 'value: empty list' ->
        before ->
          parser := create-parser 'x', []

        specify 'is empty' ->
          expect(parser.is-empty!).to.be.ok

      context 'value: non-empty list' ->
        before ->
          parser := create-parser 'x', ['x']

        specify 'is empty' ->
          expect(parser.is-empty!).to.not.be.ok

    describe 'is-collection' ->
      # 'collection' if @all-are 'Object'
      context 'value: Object list' ->
        before ->
          parser := create-parser 'x', [{x: 2}, {y: 5}]

        specify 'is a collection of objects' ->
          expect(parser.is-array!).to.not.be.ok

      context 'value: String list' ->
        before ->
          parser := create-parser 'x', ['a', 'b']

        specify 'is NOT a collection of objects' ->
          expect(parser.is-collection!).to.not.be.ok

    describe 'is-array' ->
      # 'array' if @all-are @primitive-types!
      context 'value: String list' ->
        before ->
          parser := create-parser 'x', ['a', 'b']

        specify 'is a primitives array' ->
          expect(parser.is-array!).to.be.ok

      context 'value: Object list' ->
        before ->
          parser := create-parser 'x', [{x: 2}, {y: 5}]

        specify 'is NOT a primitives array' ->
          expect(parser.is-array!).to.not.be.ok

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
