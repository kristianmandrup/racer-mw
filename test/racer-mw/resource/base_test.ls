Class    = require('jsclass/src/core').Class
requires = require '../../../requires'

requires.test 'test_setup'

expect        = require('chai').expect

requires = require '../../../requires'

BaseResource        = requires.aresource 'base'
ModelResource       = requires.aresource 'model'
AttributeResource   = requires.aresource 'attribute'
CollectionResource  = requires.aresource 'collection'

BasePipe          = requires.apipe 'base'
CollectionPipe    = requires.apipe 'collection'
ModelPipe         = requires.apipe 'model'
AttributePipe     = requires.apipe 'attribute'
PathPipe          = requires.apipe 'path'

describe 'BaseResource' ->
  var base-res, model-res, att-res, col-res, pipe

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take context' ->
        expect(-> new BaseResource).to.throw

  context 'a base resource' ->
    before ->
      base-res := new BaseResource {}

    specify 'has a function scoped' ->
      expect(base-res.scoped).to.be.an.instance-of Function

    specify 'has a function save' ->
      expect(base-res.save).to.be.an.instance-of Function

    specify 'has a function at' ->
      expect(base-res.at).to.be.an.instance-of Function

    specify 'resource-type is Base' ->
      expect(base-res.resource-type).to.eq 'Base'

    describe.only 'obtain path from resource' ->
      var user
      before ->
        user := {name: 'Kris'}
        pipe = new ModelPipe(user: user)
        model-res := new ModelResource pipe: pipe
        model-res.full-path = '_path.user'

      specify 'is user' ->
        expect(model-res.path!).to.eq 'user'

    describe 'obtain path from Model Pipe' ->
      var user
      before ->
        user := {name: 'Kris'}
        pipe = new PathPipe('_path').model(user: user)
        model-res := new ModelResource pipe: pipe

      specify 'is user' ->
        expect(model-res.path!).to.eq 'user'


