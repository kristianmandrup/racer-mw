describe 'TupleObjectParser' ->
  describe 'initialize(@key, @value)' ->

  describe 'parse-single' ->
    # @validate-string-key!
    # @model! or @attribute! or @unknown! @none!

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