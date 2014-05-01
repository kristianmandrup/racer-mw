Class   = require 'jsclass/src/core' .Class
get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ArraySetter       = get.value-object-setter 'array'
ArrayValueObject  = get.value-object 'array'

item-setter = get.value-object-setter 'item'
ItemSetter  = item-setter.ItemSetter
ItemPusher  = item-setter.ItemPusher


describe 'ArraySetter' ->
  var value-obj, arr-setter, val

  describe 'initialize(value-obj)' ->
    specify 'no args' ->
      expect(-> new ArraySetter).to.throw Error

  describe 'instance: empty' ->
    before-each ->
      value-obj := new ArrayValueObject value: []
      arr-setter    := new ArraySetter value-obj
      arr-setter.set []

    describe 'arr-setter' ->
      specify 'is an ArraySetter' ->
        expect(arr-setter).to.be.an.instance-of ArraySetter

    describe 'value-obj' ->
      xspecify 'value is []' ->
        expect(value-obj.value).to.eql []

    describe 'value' ->
      xspecify 'same as in value-obj' ->
        expect(arr-setter.value).to.eql value-obj.value

      specify 'is []' ->
        expect(arr-setter.value).to.eql []

    describe 'validate-at-pos' ->
      specify 'is valid' ->
        expect(arr-setter.validate-at-pos!).to.be.true

    describe 'at-pos' ->
      # @index = @options.at or 0
      specify 'is default 0' ->
        expect(arr-setter.at-pos!).to.eql 0

    describe 'sliced' ->
      # @sliced = @value.slice @index, @list.length
      specify 'is empty list' ->
        expect(arr-setter.sliced!).to.eql []

    describe 'max-length' ->
      # Math.max(@sliced!.length, @list.length)
      specify 'is 0' ->
        expect(arr-setter.max-length!).to.eql 0

    describe 'sliced.length' ->
      # @sliced.length is @max-length!
      specify 'is 0' ->
        expect(arr-setter.sliced!length).to.eql 0

    describe 'sliced-is-longer' ->
      # @sliced.length is @max-length!
      specify 'is false - both 0' ->
        expect(arr-setter.sliced-is-longer!).to.be.false

    describe 'longest-list' ->
      # if @sliced-is-longer! then @sliced else @list
      specify 'is list, since both 0' ->
        expect(arr-setter.longest-list!).to.eq arr-setter.list

    describe 'pusher' ->
      # new Pusher @list
      specify 'is a Pusher' ->
        expect(arr-setter.item-pusher!).to.be.an.instance-of ItemPusher

    describe 'setter' ->
      # new Setter @list
      specify 'is a Pusher' ->
        expect(arr-setter.item-setter!).to.be.an.instance-of ItemSetter


    describe 'set(@list, @options = {})' ->
      # @validate-index! ;  ; @set-list!
      specify 'does not throw' ->
        expect(arr-setter.set [1,2], at: 0).to.not.throw

    describe 'set-it(index)' ->
      # @settter.set index unless @no-item-at index
      specify 'does not throw' ->
        arr-setter.list = [1,2]
        expect(arr-setter.set-it 0).to.not.throw

    describe 'no-item-at(index)' ->
      # @sliced[index] is void
      specify 'no item in pos 3' ->
        arr-setter._sliced = [1,2]
        expect(arr-setter.no-item-at 3).to.be.true

      specify 'an item in pos 1' ->
        arr-setter._sliced = [1,2]
        expect(arr-setter.no-item-at 1).to.be.false

    describe 'push-it(index)' ->
      # @pusher.push! index
      specify 'push [3] at pos 2' ->
        arr-setter.list = [3]
        arr-setter.push-it 2
        expect(arr-setter.list).to.include 3

    describe 'set-list' ->
      # @sliced!
      # for let item, index in @longest-list!
        # @set-it(index) or @push-it(index)
      specify 'push [3] at pos 2' ->
        arr-setter.value = [1,2]
        arr-setter.list = [3]
        arr-setter.set-it 1
        expect(arr-setter.list).to.eql [2,3]


    validate-index: ->
      # @index! ; @index-error! unless @valid-index!


