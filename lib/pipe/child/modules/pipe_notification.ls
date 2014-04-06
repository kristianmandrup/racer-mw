Module       = require('jsclass/src/core').Module

PipeNotification = new Module(
  auto-update: true

  # sent to parent pipe
  on-child-update: (child, value, options = {}) ->
    @set-value value, no-child: true if @auto-update
)

module.exports = PipeNotification