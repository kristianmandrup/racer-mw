requires = require '../../../requires'

requires.test 'test_setup'

AttributeResource   = requires.resource 'attribute'

expect        = require('chai').expect

describe 'AttributeResource' ->
  var att-res, pipe

  pipes = {}
  resources = {}

  describe 'init' ->
    context 'no args' ->
      specify 'creates it' ->
        expect(-> new AttributeResource).to.not.throw

  context 'a basic AttributeResource obj' ->
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

  context 'AttributeResource obj created from pipe' ->
    before ->
      pipes.att.admin := new AttributePipe admin: 7
      resources.att := new AttributeResource pipe

    specify 'resource set with pipe' ->
      expect(resources.att.pipe).to.eq pipes.att.admin

    specify 'pipe set with resource' ->
      expect(pipes.att.admin.$res).to.eq resources.att
