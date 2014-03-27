requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

util = require 'util'

KeyParser       = requires.pipe   'parser/key_parser'

describe 'KeyParser' ->
  var key-parser, obj

  describe 'initialize(obj)' ->
    before ->
      obj :=
        x: 2
      key-parser := new KeyParser obj

    describe 'parse' ->
      specify '..' ->
        # @no-keys! or @parse-keys!

    describe 'no-keys' ->
      specify '..' ->
        # [] if @keys.length is 0

    describe 'parse-keys' ->
      specify '..' ->
        # @first-mapped! or @mapped

    describe 'first-mapped' ->
      specify '..' ->
        # @mapped.first! if @mapped.length is 1

    describe 'mapped' ->
      specify '..' ->
        # @_mapped ||= @map keys

    describe 'mapped' ->
      specify '..' ->

    describe 'mapped' ->
      specify '..' ->
        # map-key: (key) ->