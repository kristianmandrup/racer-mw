requires = require '../../../../../../requires'

Class       = require('jsclass/src/core').Class

requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
require 'sugar'

TupleValueTyper = requires.pipe 'parser/tuple/typer/tuple_value_typer'

describe 'TupleValueTyper' ->
  var value-typer

  create-value-typer = (value) ->
    new TupleValueTyper value

  describe 'is-array' ->
    # @list-type! is 'array'

  describe 'is-collection' ->
    # @list-type! in @collection-types

  describe 'collection-types' ->
    # ['collection', 'empty']

  describe 'is-empty' ->
    # 'empty' if not @value or @value.length is 0
    context 'value: void' ->
      before ->
        value-typer := create-value-typer 'x'

      specify 'is empty' ->
        expect(value-typer.is-empty!).to.be.ok

    context 'value: empty list' ->
      before ->
        value-typer := create-value-typer 'x', []

      specify 'is empty' ->
        expect(value-typer.is-empty!).to.be.ok

    context 'value: non-empty list' ->
      before ->
        value-typer := create-value-typer 'x', ['x']

      specify 'is empty' ->
        expect(value-typer.is-empty!).to.not.be.ok

  describe 'is-collection' ->
    # 'collection' if @all-are 'Object'
    context 'value: Object list' ->
      before ->
        value-typer := create-value-typer 'x', [{x: 2}, {y: 5}]

      specify 'is a collection of objects' ->
        expect(value-typer.is-array!).to.not.be.ok

    context 'value: String list' ->
      before ->
        value-typer := create-value-typer 'x', ['a', 'b']

      specify 'is NOT a collection of objects' ->
        expect(value-typer.is-collection!).to.not.be.ok

  describe 'is-array' ->
    # 'array' if @all-are @primitive-types!
    context 'value: String list' ->
      before ->
        value-typer := create-value-typer 'x', ['a', 'b']

      specify 'is a primitives array' ->
        expect(value-typer.is-array!).to.be.ok

    context 'value: Object list' ->
      before ->
        value-typer := create-value-typer 'x', [{x: 2}, {y: 5}]

      specify 'is NOT a primitives array' ->
        expect(value-typer.is-array!).to.not.be.ok

  describe 'all-are(types)' ->
    # @value.every (item) ->
    #   typeof! item in [types].flatten!
    context 'value: String list' ->
      before ->
        value-typer := create-value-typer 'x', ['a', 'b']

      specify 'are all string' ->
        expect(value-typer.all-are 'String').to.be.ok

      specify 'are all number' ->
        expect(value-typer.all-are 'Number').to.be.false

    context 'value: String and Number list' ->
      before ->
        value-typer := create-value-typer 'x', ['a', 3, 'b']

      specify 'are all string' ->
        expect(value-typer.all-are value-typer.primitive-types).to.be.ok

  describe 'primitive-types' ->
    # * \String
    # * \Number

    specify 'has String and Number' ->
      expect(value-typer.primitive-types).to.include 'String', 'Number'