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

describe 'ResourceValue' ->
  var base-res, model-res, att-res, col-res, pipe

  var user
  before ->
    user := {name: 'Kris'}

  context 'Model Resource' ->
    before ->
      model-res := new ModelResource {}
      pipe = new PathPipe('_path').model(user: user)

    describe 'attach' ->
      context 'default: no transfer pipe value' ->
        before ->
          pipe := new ModelPipe(user: {})
          model-res.attach-to pipe

        specify 'attaches to pipe' ->
          expect(model-res.pipe).to.eq pipe

        specify 'does not transfer value from pipe' ->
          expect(model-res.value).to.not.eq pipe.value!

    describe 'detach' ->
      context 'default: no transfer pipe value' ->
        before ->
          pipe := new ModelPipe(user: {})
          model-res.attach-to pipe
          model-res.detach!

        specify 'detaches from pipe' ->
          expect(model-res.pipe).to.be.undefined

        specify 'should-transfer: false' ->
          expect(model-res.should-transfer!).to.be.false

        specify 'does not transfer value-obj from pipe' ->
          expect(model-res.value-obj).to.not.eq pipe.value-obj

        specify 'does not transfer value from pipe' ->
          expect(model-res.value).to.not.eq pipe.value!

    context 'transfer pipe value' ->
      var val

      before ->
        pipe := new ModelPipe(user: {name: 'kris'})
        model-res := new ModelResource pipe: pipe
        model-res.attach-to pipe
        val := model-res.detach transfer: true

      specify 'detaches from pipe' ->
        expect(model-res.pipe).to.be.undefined

      specify 'should-transfer: true' ->
        expect(model-res.should-transfer transfer: true).to.be.true

      specify 'detach returns detached value object' ->
        expect(val.value).to.eq pipe.value!

      specify 'transfers value-obj from pipe' ->
        expect(model-res.value-obj.value).to.eq pipe.value-obj.value

      specify 'Model Resource value is: kris' ->
        expect(model-res.value!).to.eql {name: 'kris'}

      specify 'Pipe value is: kris' ->
        expect(pipe.value!).to.eql {name: 'kris'}

      describe 'value-object' ->
        specify 'has none' ->
          expect(-> model-res.value!).to.throw