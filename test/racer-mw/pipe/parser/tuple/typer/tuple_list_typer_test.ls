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


