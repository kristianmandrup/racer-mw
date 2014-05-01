Class   = require 'jsclass/src/core' .Class
get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ItemMutator = get.value-object-item 'mutator'

describe 'ItemMutator' ->
  var mutator, container, list

  describe 'initialize' ->
    # console.log 'ItemMutator', ItemMutator

    specify 'no args' ->
      expect(-> new ItemMutator).to.throw Error

    specify 'container' ->
      expect(-> new ItemMutator {}).to.not.throw Error

    specify 'container and empty list' ->
      expect(-> new ItemMutator({}, [])).to.not.throw Error
