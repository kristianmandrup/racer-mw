describe 'TupleListParser' ->
  describe 'initialize(@key, @value)' ->

  # collection or simple array
  describe 'parse-plural' ->
    # @array! or @collection! or @none!

  describe 'is-array' ->
    # @list-type! is 'array'

  describe 'is-collection' ->
    @list-type! in @collection-types

  describe 'collection-types' ->
    # ['collection', 'empty']

  describe 'collection' ->
    # return unless @is-collection!
    # @value ||= []
    # build 'collection'

  describe 'array' ->
    # return unless @is-array!
    # @build 'attribute'

  describe 'none' ->
    # throw new Error "Unable to determine if plural: #{@key} is a collection or array, was: #{@list-type!}"

  build: (name) ->
    @validate-array!; @call-super!