requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

util = require 'util'

KeyParser       = requires.pipe   'parser/key_parser'

describe 'KeyParser' ->
  var key-parser, obj

  describe 'initialize(obj)' ->
    specify 'no arg - fails' ->
      expect(-> new KeyParser).to.throw Error

    specify 'string arg - fails' ->
      expect(-> new KeyParser 'x').to.throw Error

    specify 'obj arg - ok' ->
      expect(-> new KeyParser x:2).to.not.throw

  context 'no keys instance' ->
    before ->
      key-parser := new KeyParser {}

    describe 'parse' ->
      specify '..' ->
        # @no-keys! or @parse-keys!
        expect(key-parser.parse!).to.eql []

    describe 'no-keys' ->
      specify '..' ->
        # [] if @keys.length is 0
        expect(key-parser.no-keys!).to.eql []

  context 'one key instance' ->
    before ->
      key-parser := new KeyParser {x: 2}

    describe 'no-keys' ->
      specify '..' ->
        # [] if @keys.length is 0
        expect(key-parser.no-keys!).to.be.undefined

    describe 'parse-keys' ->
      specify '..' ->
        # @first-mapped! or @mapped
        expect(key-parser.parse-keys!).to.be.undefined

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

  context 'multi key instance' ->