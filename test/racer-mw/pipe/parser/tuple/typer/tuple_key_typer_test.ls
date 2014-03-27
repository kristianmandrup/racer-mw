requires = require '../../../../../../requires'

Class       = require('jsclass/src/core').Class

requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
require 'sugar'

TupleKeyTyper = requires.pipe 'parser/tuple/typer/typer/tuple_key_typer'

describe 'TupleKeyTyper' ->
  var key-typer

  create-key-typer = (key) ->
    new TupleKeyTyper 'x'

  describe 'initialize(key)' ->
    specify 'no args - fails' ->
      expect(-> new TupleKeyTyper).to.throw Error

    specify 'object arg - fails' ->
      expect(-> new TupleKeyTyper {}).to.throw Error

    specify 'string arg - ok' ->
      expect(-> new TupleKeyTyper 'x').to.not.throw Error

  context 'instance for x' ->
    before ->
      key-typer := create-key-typer 'x'

    describe 'tuple-type-is' ->
      specify 'single' ->
        expect(key-typer.tuple-type-is 'Single').to.be.ok

    describe 'tuple-type' ->
      # @any-of \path \single \plural \none
      specify 'is single' ->
        expect(key-typer.tuple-type!).to.eql 'Single'

    describe 'any-of(...names)' ->

    describe 'path' ->
      # 'Path'    if @a-path!
      specify 'is not' ->
        expect(key-typer.path!).to.not.be.ok

    describe 'single' ->
      # 'Single'  if @a-single!
      specify 'yes' ->
        expect(key-typer.single!).to.be.ok

    describe 'plural' ->
      # 'Plural'  if @a-plural!
      specify 'no' ->
        expect(key-typer.plural!).to.not.be.ok

    describe 'none' ->
      # throw new Error "Can't determine tuple type from key: #{@key}"
      specify 'no' ->
        expect(-> key-typer.none!).to.throw Error

    describe 'a-plural' ->
      # @key.pluralize!   is @key
      specify 'no' ->
        expect(key-typer.a-plural!).to.not.be.ok

    describe 'a-single' ->
      # @key.singularize! is @key
      specify 'yes' ->
        expect(key-typer.a-single!).to.be.ok

    describe 'a-path' ->
      # @key[0] in ['_', '$']
      specify 'yes' ->
        expect(key-typer.a-single!).to.not.be.ok