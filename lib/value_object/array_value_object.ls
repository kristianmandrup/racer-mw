Class   = require('jsclass/src/core').Class
get     = require '../../requires' .get!
_       = require 'prelude-ls'
lo      = require 'lodash'
require 'sugar'

ValueObject       = get.value-object 'base'

ArrayValueSetter  = get.value-object 'base'

# Parser        = get.base-module 'parser'

# Also enable contract: true option, to contract original array or false: ignore remaining elements

ArrayValueObject = new Class(ValueObject,
  initialize: (@options = {}) ->
    @call-super! if @call-super?
    @

  parser: ->
    new Parser void, parent: @container

  set-value: (list, options = {}) ->
    @valid = @validate list
    # @set-list list, options if @valid

  set-list: (list, options = {}) ->
    @setter!.set list, options

  refresh-value: ->
    @value = @container.raw-value! if @container?
    # console.log 'pipe', @container.describe!
    console.log 'VALUE' @value
    @value

  setter: ->
    @setter = new ArrayValueSetter @
)

module.exports = ArrayValueObject