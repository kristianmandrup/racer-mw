Class       = require('jsclass/src/core').Class

get = require '../../../../requires' .get!
get.test 'test_setup'
expect = require('chai').expect

BasePipe        = get.apipe 'base'
RawExtractor    = get.pipe-value 'raw_extractor'

describe 'RawExtractor' ->
  var extractor, pipe, obj

  describe 'initialize(@pipe, @obj, @contained)' ->
    before ->
      pipe := new BasePipe 'x'

    specify 'no args - fails' ->
      expect(-> new RawExtractor).to.throw Error

    specify 'pipe and object - ok' ->
      expect(-> new RawExtractor pipe, {x:2}).to.not.throw Error

  context 'instance - not contained' ->
    # @pipe-type = @pipe.pipe-type
    describe 'pipe-type' ->

    describe 'id' ->
      # @pipe.id!

    describe 'inner-raw' ->
      # return {(@id!): @obj} if @contained
      # @obj

    describe 'child-value(child)' ->
      # return child.raw-value! if @is-collection!
      # child.raw-value true

    describe 'is-collection' ->

  context 'instance - contained' ->
