Class         = require('jsclass/src/core').Class
get           = require '../../../../requires' .get!
ValueObject   = get.value-object 'base'

PipeUpdateValueHelper = new Class(
  initialize: (@pipe, @value, @options = {}) ->
    @value-obj = @pipe.value-obj
    @

  set: (@value, @options = {}) ->
    @

  # options can be fx:
  #   at: 2
  # to start inserting at position 2
  update: ->
    @update-value-obj! and @notify-family!

  update-value-obj: ->
    @value-obj.set @value, @options

  notify-family: ->
    @family-notifier!notify @value!

  family-notifier: ->
    new FamilyNotifier @, @options
)

