requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

AttributesPipe    = requires.pipe 'attributes'
ModelPipe         = requires.pipe 'model'
AttributePipe     = requires.pipe 'attribute'
PathPipe          = requires.pipe 'path'
CollectionPipe    = requires.pipe 'collection'


describe 'AttributesPipe' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new AttributesPipe).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipe obj).to.throw

    context 'arg: AttributePipe' ->
      var attr-pipe

      before ->
        attr-pipe := new AttributePipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipe attr-pipe).to.throw

    context 'arg: PathPipe' ->
      var path-pipe

      before ->
        path-pipe := new PathPipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipe path-pipe).to.not.throw

    # TODO: should allow this :)
    context 'arg: ModelPipe' ->
      var model-pipe

      before ->
        model-pipe := new ModelPipe name: {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipe model-pipe).to.not.throw

    context 'arg: CollectionPipe' ->
      var col-pipe

      before ->
        col-pipe := new CollectionPipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipe col-pipe).to.throw

    context 'ModelPipe with attributes' ->
      var model-pipe, attrs

      before ->
        model-pipe  := new ModelPipe name: {}
        attrs       := new AttributesPipe model-pipe

      specify 'is a AttributePipesPipe' ->
        expect(attrs).to.be.an.instance-of AttributesPipe

      specify 'parent-pipe is the ModelPipe' ->
        expect(attrs.parent-pipe).to.eq model-pipe

      specify 'create-pipe returns a AttributePipe' ->
        expect(attrs.create-pipe 'age').to.be.an.instance-of AttributePipe

      describe 'add' ->
        specify 'returns attributes' ->
          expect(attrs.add 'age').to.eq attrs

        describe 'age attribute pipe added' ->
          var added, parent-child

          before ->
            pipe := attrs.add 'age'
            added := pipe.added.first!
            parent-child := pipe.parent-pipe.child 'age'

          specify 'adds AttributePipe age' ->
            expect(added.name).to.eq 'age'

          specify 'adds AttributePipe age' ->
            expect(parent-child.name).to.eq 'age'

          specify 'adds the AttributePipe age' ->
            expect(model-pipe.child('age').name).to.eq 'age'