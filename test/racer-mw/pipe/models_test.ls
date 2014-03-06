requires = require '../../../requires'

requires.test 'test_setup'

expect            = require('chai').expect

ModelsPipe        = requires.pipe 'models'
ModelPipe         = requires.pipe 'model'
AttributePipe     = requires.pipe 'attribute'
PathPipe          = requires.pipe 'path'
CollectionPipe    = requires.pipe 'collection'

describe 'ModelsPipe' ->
  var models, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new ModelsPipe).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipe obj).to.throw

    context 'arg: AttributePipe' ->
      var attr-pipe

      before ->
        attr-pipe := new AttributePipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipe attr-pipe).to.throw

    context 'arg: PathPipe' ->
      var path-pipe

      before ->
        path-pipe := new PathPipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipe path-pipe).to.throw

    # TODO: should allow this for named models that become attributes on parent model
    context 'arg: ModelPipe' ->
      var model-pipe

      before ->
        model-pipe := new ModelPipe name: {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipe model-pipe).to.throw

    context 'arg: CollectionPipe' ->
      var col-pipe

      before ->
        col-pipe := new CollectionPipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelsPipe col-pipe).to.not.throw

    context 'CollectionPipe with models' ->
      var col-pipe

      before ->
        col-pipe := new CollectionPipe 'name'
        models   := new ModelsPipe col-pipe

      specify 'is a ModelsPipe' ->
        expect(models).to.be.an.instance-of ModelsPipe

      specify 'parent-pipe is the CollectionPipe' ->
        expect(models.parent-pipe).to.eq col-pipe

      specify 'create-pipe returns a ModelPipe' ->
        expect(models.create-pipe name: {}).to.be.an.instance-of ModelPipe

      describe 'add' ->
        specify 'returns models' ->
          expect(models.add name: {}).to.eq models

        # TODO: Needs a fix!
        specify 'adds the ModelPipe to the CollectionPipe' ->
          model-pipe = models.add(name: {}).added
          expect(col-pipe.child '0').to.eq model-pipe
