Class         = require('jsclass/src/core').Class
get           = require '../../../../requires' .get!
ValueObject   = get.value-object 'base'

# options can be fx:
#   at: 2
# to start inserting at position 2

PipeUpdateValueHelper = new Class(
  initialize: (@pipe, @value, @options = {}) ->
    @value-obj = @pipe.value-obj
    @

  set: (@value, @options = {}) ->
    @

  # TODO: Update with "Raw value" if notified from child, see Value helpers
  update: ->
    @update-value-obj! and @notify-family!

  update-value-obj: ->
    @value-obj.set @value, @options

  notify-family: ->
    @family-notifier!notify @value!

  family-notifier: ->
    new FamilyNotifier @, @options
)

