Module       = require('jsclass/src/core').Module

PipeValueNotification = new Module(
  auto-update: true

  # sent to child pipe
  on-parent-update: (parent, value, options = {}) ->
    @set-value value, no-parent: true if @auto-update

  # sent to parent pipe
  on-child-update: (child, value, options = {}) ->
    @set-value value, no-child: true if @auto-update
)

module.exports = PipeValueNotification