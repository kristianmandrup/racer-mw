requires = require '../../../requires'

requires.test 'test_setup'

AttributeResource   = requires.resource 'attribute'
AttributePipe       = requires.pipe 'attribute'
ModelPipe           = requires.pipe 'model'

expect        = require('chai').expect

describe 'AttributeResource' ->
  var att-res, pipe

  pipes = {}
  resources = {}

  describe 'init' ->
    context 'no args' ->
      specify 'creates it' ->
        expect(-> new AttributeResource).to.throw

  context 'AttributeResource obj created from Model pipe' ->
    before ->
      pipes.model := new ModelPipe admin: {}

    specify 'fails' ->
      expect(-> new AttributeResource pipes.model).to.throw

  context 'AttributeResource obj created from Attribute pipe' ->
    before ->
      pipes.att       := new AttributePipe admin: 7
      resources.att   := new AttributeResource pipes.att

    specify 'resource set with pipe' ->
      expect(resources.att.pipe).to.eq pipes.att

    specify 'pipe set with resource' ->
      expect(pipes.att.$res).to.eq resources.att

    specify 'has a function scoped' ->
      expect(resources.att.scoped).to.be.an.instance-of Function

    specify 'has a function save' ->
      expect(resources.att.save).to.be.an.instance-of Function

    specify 'does not have a function filter' ->
      expect(resources.att.filter).to.be.undefined

    specify 'does not have a function sort' ->
      expect(resources.att.sort).to.be.undefined

    specify 'does not have a function query' ->
      expect(att-res.query).to.be.undefined

