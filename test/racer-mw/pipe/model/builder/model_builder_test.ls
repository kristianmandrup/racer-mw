get   = require '../../../../requires' .get!
get.test 'test_setup'
expect              = require('chai').expect

PathPipe            = get.apipe 'path'
ModelPipe           = get.apipe 'model'

ModelPipeBuilder    = get.model-builder 'model'

describe 'ModelPipeBuilder' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take an object that can attach' ->
        expect(-> new ModelPipeBuilder).to.throw

  context 'Path pipe' ->
    before ->
      pipe := new PathPipe '_path'

    describe 'init' ->
      specify 'pass pipe - success' ->
        expect(-> new ModelPipeBuilder pipe).to.not.throw

    describe 'model' ->
      var model, attributes, user

      context 'a user model' ->
        var user-model, proj-model, project

        before ->
          project :=
            name: 'My project'
            _clazz: 'project'

          builder = new ModelPipeBuilder pipe
          proj-model := builder.build project

        describe 'model to add project model attribute' ->
          # should use _clazz as id: project
          specify 'is a project model' ->
            expect(proj-model).to.be.an.instance-of ModelPipe
