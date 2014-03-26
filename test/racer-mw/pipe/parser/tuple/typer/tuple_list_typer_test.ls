requires = require '../../../../../../requires'

Class       = require('jsclass/src/core').Class

requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
require 'sugar'

TupleListTyper = requires.pipe 'parser/tuple/typer/tuple_list_typer'

describe 'TupleListTyper' ->
  var list-typer

  describe 'calc-list-type' ->

  describe 'is-array' ->
    # @list-type! is 'array'


