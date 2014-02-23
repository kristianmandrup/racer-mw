Class    = require('jsclass/src/core').Class
requires = require '../../../requires'

requires.test 'test_setup'

requires = require '../../../requires'

AttributeResource   = requires.resource 'attribute'

expect        = require('chai').expect

describe 'AttributeResource' ->
  var att-res

  describe 'init' ->
    context 'no args' ->
      specify 'creates it' ->
        expect(-> new AttributeResource).to.not.throw

  context 'a base resource' ->
    before ->
      att-res := new AttributeResource

    specify 'has a function scoped' ->
      expect(att-res.scoped).to.be.an.instance-of Function

    specify 'has a function save' ->
      expect(att-res.save).to.be.an.instance-of Function

    specify 'does not have a function filter' ->
      expect(att-res.filter).to.be.undefined

    specify 'does not have a function sort' ->
      expect(att-res.sort).to.be.undefined

    specify 'does not have a function query' ->
      expect(att-res.query).to.be.undefined
