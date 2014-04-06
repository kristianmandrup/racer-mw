Module       = require('jsclass/src/core').Module

PipeNotification = new Module(
  auto-update: true

  # sent to child pipe
  on-parent-update: (parent, value, options = {}) ->
    @set-value value, no-parent: true if @auto-update
)

module.exports = PipeNotification