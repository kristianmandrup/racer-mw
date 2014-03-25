describe 'TupleParser'

  describe 'initialize(@key, @value)' ->

  # test if value is list of Object or list of simple types
  # if mixed, throw error
  describe 'list-type' ->
    @_list-type ||= @calc-list-type!

  describe 'build(name, key, value)' ->
    # value ||= @value; key ||= @key
    # @build name, key, value

  # protected

  describe 'calc-list-type' ->
    # @validate-array "plural value #{@key}"
    # @is-empty! or @is-collection! or @is-array! or 'mixed'

  describe 'is-empty' ->
    # 'empty' if @value.length is 0

  describe 'is-collection' ->
    # 'collection' if @all-are 'Object'

  describe 'is-array' ->
    # 'array' if @all-are @primitive-types!

  describe 'all-are(types)' ->
    # @value.every (item) ->
    #   typeof! item in [types].flatten!

  describe 'primitive-types'
    # * \String
    # * \Number

  describe 'validate-array(msg = 'value')' ->
    # unless typeof! @value is 'Array'
      # throw new Error "#{msg} must be an Array, was: #{typeof! @value} #{util.inspect @value}"

  describe 'validate-string-key' ->
    # unless typeof! @key is 'String'
