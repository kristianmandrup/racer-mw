requires = require '../../../../../../requires'

Class       = require('jsclass/src/core').Class

requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'
require 'sugar'

TupleKeyTyper = requires.pipe 'parser/tuple/typer/typer/tuple_key_typer'

describe 'TupleKeyTyper' ->
  var key-typer

  describe 'tuple-type' ->
    # @any-of \path \single \plural \none

  describe 'any-of(...names)' ->

  describe 'path' ->
    # 'Path'    if @a-path!

  describe 'single' ->
    # 'Single'  if @a-single!

  describe 'plural' ->
    'Plural'  if @a-plural!

  describe 'none' ->
    # throw new Error "Can't determine tupel type from key: #{@key}"

  describe 'a-plural' ->
    # @key.pluralize!   is @key

  describe 'a-single' ->
    # @key.singularize! is @key

  describe 'a-path' ->
    # @key[0] in ['_', '$']