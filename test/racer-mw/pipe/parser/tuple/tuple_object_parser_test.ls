requires    = require '../../../../../requires'
requires.test 'test_setup'
expect      = require('chai').expect
util        = require 'util'

PipeParser  = requires.pipe 'pipe_parser'

ListParser  = requires.pipe   'parser/list_parser'

ModelPipe   = requires.apipe 'model'


TupleObjectParser = requires.pipe 'parser/tuple/tuple_object_parser'

describe 'TupleObjectParser' ->
  var parser

  describe 'initialize(@key, @value)' ->
    specify 'no arg - fails' ->
      expect(-> new TupleObjectParser).to.throw Error

    specify 'one arg - ok' ->
      expect(-> new TupleObjectParser 'x').to.not.throw Error

    specify 'creates TupleObjectParser' ->
      expect(new TupleObjectParser 'x').to.be.an.instance-of TupleObjectParser

  context 'instance' ->
    describe 'parse-single' ->
      # @validate-string-key!
      # @model! or @attribute! or @unknown! @none!

      context 'key: 0' ->
        before ->
          # TODO: only allow String as key
          parser := new TupleObjectParser 0

        specify 'not a string - fails' ->
          expect(-> parser.parse-single!).to.throw Error

      context 'key: x' ->
        before ->
          parser := new TupleObjectParser 'x'

        specify 'not a string - fails' ->
          expect(-> parser.parse-single!).to.throw Error


  describe 'model' ->
    # @build 'model' if @is-model!

  describe 'attribute' ->
    # @build 'attribute' if @is-model!

  describe 'unknown' ->
    # @build 'model' if @is-unknown!

  describe 'none' ->
    # throw new Error "Single value for #{@key} should be Object, Number or String, was: #{typeof! @value}, #{@value}"

  describe 'is-unknown' ->
    typeof! @value is 'Undefined'

  describe 'is-model' ->
    # typeof! @value is 'Object'

  describe 'is-attribute' ->
    # typeof! @value in @primitive-types

  describe 'parse-path' ->
    # @build 'children', @path-pipe!

  describe 'path-pipe' ->
    # new PathPipe @key

  describe 'parse-tupel' ->
    # @plural! or @parse-method!

  describe 'plural' ->
    # @list-parser.parse-plural! if @tupel-type! is 'Plural'

  describe 'parse-method' ->
    # @["parse#{@tuple-type!}"]

  describe 'tuple-type' ->
    # @validate-string-key!
    # @is-path! or @is-single! or @is-plural! or @is-none!

  describe 'is-path' ->
    # 'Path' if @key[0] in ['_', '$']

  describe 'is-single' ->
    # 'Single' if @key.singularize! is @key

  describe 'is-plural' ->
    # 'Plural' if @key.pluralize! is @key

  describe 'is-none' ->
    # throw new Error "Can't determine tupel type from key: #{@key}"