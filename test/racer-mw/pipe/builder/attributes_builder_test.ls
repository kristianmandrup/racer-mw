requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

AttributesPipeBuilder    = requires.apipe-builder 'attributes'

ModelPipe         = requires.apipe 'model'
AttributePipe     = requires.apipe 'attribute'
PathPipe          = requires.apipe 'path'
CollectionPipe    = requires.apipe 'collection'


describe 'AttributesPipeBuilder' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new AttributesPipeBuilder).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipeBuilder obj).to.throw

    context 'arg: AttributePipe' ->
      var attr-pipe

      before ->
        attr-pipe := new AttributePipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipeBuilder attr-pipe).to.throw

    context 'arg: PathPipe' ->
      var path-pipe

      before ->
        path-pipe := new PathPipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipeBuilder path-pipe).to.not.throw

    # TODO: should allow this :)
    context 'arg: ModelPipe' ->
      var model-pipe

      before ->
        model-pipe := new ModelPipe name: {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipeBuilder model-pipe).to.not.throw

    context 'arg: CollectionPipe' ->
      var col-pipe

      before ->
        col-pipe := new CollectionPipe 'name'

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributesPipeBuilder col-pipe).to.throw

    context 'ModelPipe with attributes' ->
      var model-pipe, attrs

      before ->
        model-pipe  := new ModelPipe name: {}
        attrs       := new AttributesPipeBuilder model-pipe

      specify 'is a AttributePipesPipe' ->
        expect(attrs).to.be.an.instance-of AttributesPipeBuilder

      specify 'container is the ModelPipe' ->
        expect(attrs.container).to.eq model-pipe

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
            parent-child := pipe.container.child 'age'

          specify 'adds AttributePipe age to attributes' ->
            expect(added.name).to.eq 'age'

          specify 'adds AttributePipe age to parent (model pipe)' ->
            expect(parent-child.name).to.eq 'age'

          specify 'adds the AttributePipe age to model pipe' ->
            expect(model-pipe.child('age').name).to.eq 'age'