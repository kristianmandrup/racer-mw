get = require '../../../../requires' .get!
get.test 'test_setup'
expect = require('chai').expect

PipeValueNotification = get.pipe-value 'value_notification'

describe 'PipeValueNotification' ->
  # sent to child pipe
  describe 'on-parent-update(parent, value, options = {})' ->
    # return unless @auto-update
    # @set-value value, no-parent: true

  # sent to parent pipe
  describe 'on-child-update(child, value, options = {})' ->
    # return unless @auto-update
    # @set-value value, no-child: true

