requires = require '../../../../../../requires'

Class       = require('jsclass/src/core').Class

requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
require 'sugar'

TupleKeyTyper = requires.pipe 'parser/tuple/typer/typer/tuple_key_typer'

describe 'TupleKeyTyper' ->
  var key-typer

  describe 'calc-list-type' ->
    # @validate-array "plural value #{@key}"
    # @is-empty! or @is-collection! or @is-array! or 'mixed'
    context 'value: Object list' ->
      before ->
        key-typer := create-key-typer 'x', [{x: 2}, {y: 5}]

      specify 'is a collection' ->
        expect(key-typer.calc-list-type!).to.eql 'collection'

    context 'value: String list' ->
      before ->
        key-typer := create-key-typer 'x', ['a', 'b']

      specify 'is an array' ->
        expect(key-typer.calc-list-type!).to.eql 'array'

    context 'value: Mixed list' ->
      before ->
        key-typer := create-key-typer 'x', ['a', {x:2}, 'b']

      specify 'is mixed' ->
        expect(key-typer.calc-list-type!).to.eql 'mixed'