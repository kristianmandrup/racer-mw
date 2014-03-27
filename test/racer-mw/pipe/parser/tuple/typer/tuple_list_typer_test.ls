requires = require '../../../../../../requires'

Class       = require('jsclass/src/core').Class

requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
require 'sugar'

TupleListTyper = requires.pipe 'parser/tuple/typer/tuple_list_typer'

describe 'TupleListTyper' ->
  var list-typer

  create-list-typer = (value) ->
    new TupleListTyper value

  describe 'calc-list-type' ->
    # @validate-array "plural value #{@key}"
    # @is-empty! or @is-collection! or @is-array! or 'mixed'
    context 'value: Object list' ->
      before ->
        list-typer := create-list-typer [{x: 2}, {y: 5}]

      specify 'is a collection' ->
        expect(list-typer.calc-list-type!).to.eql 'collection'

    context 'value: String list' ->
      before ->
        list-typer := create-list-typer ['a', 'b']

      specify 'is an array' ->
        expect(list-typer.calc-list-type!).to.eql 'array'

    context 'value: Mixed list' ->
      before ->
        list-typer := create-list-typer ['a', {x:2}, 'b']

      specify 'is mixed' ->
        expect(list-typer.calc-list-type!).to.eql 'mixed'

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
        list-typer := create-list-typer 'x'

      specify 'is empty' ->
        expect(list-typer.is-empty!).to.be.ok

    context 'value: empty list' ->
      before ->
        list-typer := create-list-typer 'x', []

      specify 'is empty' ->
        expect(list-typer.is-empty!).to.be.ok

    context 'value: non-empty list' ->
      before ->
        list-typer := create-list-typer 'x', ['x']

      specify 'is empty' ->
        expect(list-typer.is-empty!).to.not.be.ok

  describe 'is-collection' ->
    # 'collection' if @all-are 'Object'
    context 'value: Object list' ->
      before ->
        list-typer := create-list-typer 'x', [{x: 2}, {y: 5}]

      specify 'is a collection of objects' ->
        expect(list-typer.is-array!).to.not.be.ok

    context 'value: String list' ->
      before ->
        list-typer := create-list-typer 'x', ['a', 'b']

      specify 'is NOT a collection of objects' ->
        expect(list-typer.is-collection!).to.not.be.ok

  describe 'is-array' ->
    # 'array' if @all-are @primitive-types!
    context 'value: String list' ->
      before ->
        list-typer := create-list-typer 'x', ['a', 'b']

      specify 'is a primitives array' ->
        expect(list-typer.is-array!).to.be.ok

    context 'value: Object list' ->
      before ->
        list-typer := create-list-typer 'x', [{x: 2}, {y: 5}]

      specify 'is NOT a primitives array' ->
        expect(list-typer.is-array!).to.not.be.ok

  describe 'all-are(types)' ->
    # @value.every (item) ->
    #   typeof! item in [types].flatten!
    context 'value: String list' ->
      before ->
        list-typer := create-list-typer 'x', ['a', 'b']

      specify 'are all string' ->
        expect(list-typer.all-are 'String').to.be.ok

      specify 'are all number' ->
        expect(list-typer.all-are 'Number').to.be.false

    context 'value: String and Number list' ->
      before ->
        list-typer := create-list-typer 'x', ['a', 3, 'b']

      specify 'are all string' ->
        expect(list-typer.all-are list-typer.primitive-types).to.be.ok
