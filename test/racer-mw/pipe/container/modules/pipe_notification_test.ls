Class  = require('jsclass/src/core').Class
get = require '../../../../../requires' .get!
get.test 'test_setup'
expect = require('chai').expect

PipeValue             = get.base-module 'value'
PipeValueNotification = get.base-module 'value_notification'

ValuePipe = new Class(
  include:
    * PipeValue
    * PipeValueNotification
    ...

  initialize: ->
    @
)

describe 'PipeValueNotification module' ->
  describe 'include module' ->
    specify 'works' ->
      expect(-> new ValuePipe).to.not.throw Error

    specify 'gets expected notify methods' ->
      expect(new ValuePipe.on-child-update).to.be.a Function
      expect(new ValuePipe.on-parent-update).to.be.a Function

  # sent to child pipe
  describe 'on-parent-update(parent, value, options = {})' ->
    # return unless @auto-update
    # @set-value value, no-parent: true

  # sent to parent pipe
  describe 'on-child-update(child, value, options = {})' ->
    # return unless @auto-update
    # @set-value value, no-child: true

