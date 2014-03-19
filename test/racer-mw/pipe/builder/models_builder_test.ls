requires = require '../../../../requires'

requires.test 'test_setup'

expect            = require('chai').expect

ModelsPipeBuilder = requires.apipe-builder 'models'
ModelPipe         = requires.apipe 'model'
AttributePipe     = requires.apipe 'attribute'
PathPipe          = requires.apipe 'path'
CollectionPipe    = requires.apipe 'collection'

describe 'ModelsPipeBuilder' ->
  var models, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new ModelsPipeBuilder).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipeBuilder obj).to.throw

    context 'arg: AttributePipe' ->
      var attr-pipe

      before ->
        attr-pipe := new AttributePipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipeBuilder attr-pipe).to.throw

    context 'arg: PathPipe' ->
      var path-pipe

      before ->
        path-pipe := new PathPipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipeBuilder path-pipe).to.throw

    # TODO: should allow this for named models that become attributes on parent model
    context 'arg: ModelPipe' ->
      var model-pipe

      before ->
        model-pipe := new ModelPipe name: {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipeBuilder model-pipe).to.throw

    context 'arg: CollectionPipe' ->
      var col-pipe

      before ->
        col-pipe := new CollectionPipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipeBuilder col-pipe).to.not.throw

    context 'CollectionPipe with models' ->
      var col-pipe

      before ->
        col-pipe := new CollectionPipe 'users'
        models   := new ModelsPipeBuilder col-pipe

      specify 'is a ModelsPipeBuilder' ->
        expect(models).to.be.an.instance-of ModelsPipeBuilder

      specify 'parent-pipe is the CollectionPipe' ->
        expect(models.parent-pipe).to.eq col-pipe

      specify 'create-pipe returns a ModelPipe' ->
        expect(models.create-pipe name: {}).to.be.an.instance-of ModelPipe

      describe 'add' ->
        specify 'returns models' ->
          expect(models.add name: {}).to.eq models

        specify 'describe-children' ->
          # console.log col-pipe.describe-children!.first!
          expect(col-pipe.describe-children!.first!.id).to.eq '0'

        specify 'child-types' ->
          # console.log col-pipe.child-types!
          expect(col-pipe.child-types!.first!).to.eq 'Model'

        specify 'adds the ModelPipe to the CollectionPipe' ->
          model-pipe = models.add(name: {}).first!
          expect(col-pipe.child '0').to.eq model-pipe

        specify 'child names 0, 1' ->
          expect(col-pipe.child-names!).to.include('0', '1')

      describe.only 'add models without clazz' ->
        specify 'assume clazz is singular of collection: user' ->
          models.add name: 'Kris'
          expect(models.first!.clazz).to.eq 'user'

    context 'ModelPipe with models' ->
      var mod-pipe

      before ->
        mod-pipe := new ModelPipe 'admin'
        models   := new ModelsPipeBuilder mod-pipe

      specify 'is a ModelsPipeBuilder' ->
        expect(models).to.be.an.instance-of ModelsPipeBuilder

