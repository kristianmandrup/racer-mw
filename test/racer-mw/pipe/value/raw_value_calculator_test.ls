Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

BasePipe            = get.apipe 'base'
RawValueCalculator  = get.pipe-value 'raw_value_calculator'

describe 'RawValueCalculator' ->
  describe 'initialize(@pipe, @contained)' ->
    # @obj = {}

  describe 'raw-value' ->
    # @raw-children-value! or @value!

  describe 'raw-children-value' ->
    # return unless @has-children!
    # @obj = @raw-extractor(@obj).inner-raw!
    # lo.each @child-list!, @set-child-value, @

  describe 'set-child-value(child)' ->
    # @obj[child.id!] = @raw-extractor!.child-value(child)

  describe 'raw-extractor(obj)' ->
    # @extractor ||= new RawExtractor @, @obj, @contained
