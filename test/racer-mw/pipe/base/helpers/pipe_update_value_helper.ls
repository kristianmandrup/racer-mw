get    = require '../../../../../requires' .get!
expect = require('chai').expect
get.test 'test_setup'


PipeUpdateValueHelper = get.base-helper 'update_value'

describe 'PipeUpdateValueHelper' ->
  var v-helper, pipe, options

  describe 'initialize(@pipe, @value, @options = {})' ->
    # @value-obj = @pipe.value-obj
    specify 'no args - fails' ->
      expect(-> new PipeUpdateValueHelper).to.throw Error

    specify 'pipe and value - ok' ->
      expect(-> new PipeUpdateValueHelper pipe).to.throw Error

    specify 'pipe arg - fails (no value)' ->
      expect(-> new PipeUpdateValueHelper pipe, value).to.not.throw Error

  context 'instance' ->
    before ->
      options := x: 2
      v-helper := new PipeUpdateValueHelper pipe, value,

    # options can be fx:
    #   at: 2
    # to start inserting at position 2
    describe 'set w options hash' ->
      expect(v-helper.options).to.eq options

    describe 'set(@value, @options = {})' ->
      specify 'set new value' ->
        v-helper.set 7, x: 3
        expect(v-helper.value).to.eql 7

      specify 'and options' ->
        expect(v-helper.options).to.eql x: 3

    describe 'update' ->
      # @update-value-obj! and @notify-family!
      specify 'and options' ->
        expect(v-helper.options).to.eql x: 3


    describe 'update-value-obj' ->
      # @value-obj.set @value, @options
      specify 'updates value-obj indeed' ->
        v-helper.update-value-obj!
        expect(v-helper.pipe.value!).to.eql v-helper.value

    describe 'notify-family' ->
      # @family-notifier!notify @value!
      specify 'updates family tree' ->
        v-helper.notify-family!
        expect(v-helper.pipe.parent.value!).to.eql 'some new value'

    describe 'family-notifier' ->
      # new FamilyNotifier @, @options
      specify 'is a FamilyNotifier' ->
        expect(v-helper.family-notifier!).to.be.an.instance-of FamilyNotifier

      specify 'with transferred pipe' ->
        expect(v-helper.family-notifier!.pipe).to.eq pipe

      specify 'and options' ->
        expect(v-helper.family-notifier!.options).to.eq v-helper.options
