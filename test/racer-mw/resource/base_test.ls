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

  context 'Model Resource' ->
    before ->
      model-res := new ModelResource {}

    describe 'detach' ->
      context 'default: no transfer pipe value' ->
        before ->
          pipe := new ModelPipe(user: {})
          model-res.attach-to pipe
          model-res.detach!

        specify 'detaches from pipe' ->
          expect(model-res.pipe).to.be.undefined

        specify 'does not transfer value from pipe' ->
          expect(model-res.value).to.not.eq pipe.value

      context 'transfer pipe value' ->
        before ->
          pipe := new ModelPipe(user: {})
          model-res.attach-to pipe
          model-res.detach transfer: true

        specify 'detaches from pipe' ->
          expect(model-res.pipe).to.be.undefined

        specify 'transfers value from pipe' ->
          expect(model-res.value).to.eq pipe.value

    describe 'attach' ->
      context 'default: no transfer pipe value' ->
        before ->
          pipe := new ModelPipe(user: {})
          model-res.attach-to pipe

        specify 'attaches to pipe' ->
          expect(model-res.pipe).to.eq pipe

        specify 'does not transfer value from pipe' ->
          expect(model-res.value).to.not.eq pipe.value

      context 'transfer pipe value' ->
        before ->
          pipe := new ModelPipe(user: {name: 'Kris'})
          model-res.value = void
          model-res.attach-to pipe, transfer: true

        specify 'attaches to pipe' ->
          expect(model-res.pipe).to.eq pipe

        specify 'transfers value from pipe' ->
          expect(model-res.value).to.eq pipe.value

    describe 'value-object' ->
      specify 'has none' ->
        expect(-> base-res.value-object!).to.throw

    describe 'set value-object directly' ->
      before ->
        base-res := new BaseResource value: 27

      specify 'is 27' ->
        expect(base-res.value-object!).to.eq 27

    describe 'obtain path from resource' ->
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

    describe 'obtain value-object from Model Pipe' ->
      var user
      before ->
        user := {name: 'Kris'}
        pipe = new ModelPipe(user: user)
        model-res := new ModelResource pipe: pipe

      specify 'is an object with name: Kris' ->
        expect(model-res.value-object!).to.eq user

    describe 'obtain value-object from Attribute Pipe' ->
      var user
      before ->
        pipe = new AttributePipe(user: 27)
        att-res := new AttributeResource pipe: pipe

      specify 'is 27' ->
        expect(att-res.value-object!).to.eq 27

    describe 'obtain Array value-object from Attribute Pipe' ->
      var user
      before ->
        pipe = new AttributePipe(list: [1,2,3])
        att-res := new AttributeResource pipe: pipe

      specify 'is a list of numbers' ->
        expect(att-res.value-object!).to.include(1,2,3)

    describe 'obtain Array value-object from Collection Pipe' ->
      var user
      before ->
        user := {_clazz: 'user', name: 'Kris'}

        pipe = new CollectionPipe('users')
        pipe.models!.add(user)
        col-res := new CollectionResource pipe: pipe

      specify 'is a list of numbers' ->
        expect(col-res.value-object!.first!).to.eq user
