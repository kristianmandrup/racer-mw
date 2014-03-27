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

  context 'instance' ->
    before ->
      value-typer := create-value-typer {x:2}

    describe 'any-of' ->
      # names.flatten!.any (name) (-> self[name])
      specify 'has model' ->
        expect(value-typer.any-of \model \attribute ).to.be.ok

    describe 'unknown' ->
      # typeof! @value is 'Undefined'
      specify 'no' ->
        expect(value-typer.unknown!).to.not.be.ok

    describe 'model' ->
      # typeof! @value is 'Object'
      specify 'yes' ->
        expect(value-typer.unknown!).to.be.ok

    describe 'attribute' ->
      # typeof! @value in @primitive-types
      specify 'no' ->
        expect(value-typer.attribute!).to.not.be.ok

    describe 'primitive-types' ->
      specify 'has String and Number' ->
        expect(value-typer.primitive-types).to.include 'String', 'Number'