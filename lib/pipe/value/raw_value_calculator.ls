Class       = require('jsclass/src/core').Class

RawExtractor = requires.pipe 'value/raw_extractor'

RawValueCalculator = new Class(
  initialize: (@pipe, @contained) ->
    @obj = {}
    @

  raw-value: ->
    @raw-children-value! or @value!

  raw-children-value: ->
    return unless @has-children!
    @obj = @raw-extractor(@obj).inner-raw!
    lo.each @child-list!, @set-child-value, @

  set-child-value: (child) ->
    @obj[child.id!] = @raw-extractor!.child-value(child)

  raw-extractor: (obj) ->
    @extractor ||= new RawExtractor @, @obj, @contained
)