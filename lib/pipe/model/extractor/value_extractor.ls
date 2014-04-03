Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

BaseExtractor = get.base-extractor 'base'

ValueExtractor = new Class(BaseExtractor,
  initialize: (@obj) ->
    @

  value: ->
    @string-value or @obj-value!

  string-value: ->
    return {} if @is-string!

  obj-value: ->
    @inner-obj!
)

module.exports = ValueExtractor