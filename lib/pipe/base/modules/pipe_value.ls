Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!

PipeUpdateValueHelper = get.base-helper 'update_value'

PipeValue = new Module(
  initialize: ->
    @value-obj = @create-value-obj!

  create-value-obj: ->
    new ValueObject @

  value: ->
    @value-obj.value

  # options can be
  #   no-parent: true
  #   no-child: true
  # these options are to avoid circular notifications in the pipe graph
  set-value: (value, options = {}) ->
    @update-value-helper!set value, options .update!

  update-value-helper: ->
    new PipeUpdateValueHelper @
)

module.exports = PipeValue