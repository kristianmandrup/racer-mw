Class   = require('jsclass/src/core').Class
get     = require '../../../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

BaseExtractor = get.model-extractor 'base'

ValueExtractor = new Class(BaseExtractor,
  initialize: (@obj, @empty-value = {}) ->
    @call-super! if @call-super?
    @

  extract: ->
    @string-value! or @obj-value! or @none!

  none: ->
    throw new Error "Model value could not be extracted from: #{@obj}"

  string-value: ->
   @empty-value if @valid-string!

  obj-value: ->
    @inner-obj! or @outer-obj!

  outer-obj: ->
    @obj if @is-object!
)

module.exports = ValueExtractor