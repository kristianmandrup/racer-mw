Class       = require('jsclass/src/core').Class

PipeValueNotification = new Module(
  # sent to child pipe
  on-parent-update: (parent, value, options = {}) ->
    return unless @auto-update
    @set-value value, no-parent: true

  # sent to parent pipe
  on-child-update: (child, value, options = {}) ->
    return unless @auto-update
    @set-value value, no-child: true

  auto-update: true
)

module.exports = PipeValueNotification