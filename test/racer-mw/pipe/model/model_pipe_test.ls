get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ModelPipe               = get.apipe 'model'
ResourceModel           = get.resource 'model'
AttributesPipeBuilder   = get.attribute-builder 'attributes'

describe 'ModelPipe' ->
  var pipe, obj

  pipes = {}

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new ModelPipe).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelPipe obj).to.throw

    context 'arg: object with _clazz' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'fails' ->
        expect(-> new ModelPipe obj).to.not.throw

      specify 'sets name to user' ->
        expect(new ModelPipe(obj).name).to.eq 'user'

      specify 'id is name (like attribute) until part of a collection' ->
        expect(new ModelPipe(obj).id!).to.eq 'user'

    context 'arg: attribute: {_clazz: name }' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'fails' ->
        expect(-> new ModelPipe admin: obj).to.not.throw

      specify 'sets name to admin' ->
        expect(new ModelPipe(admin: obj).name).to.eq 'admin'

    context 'arg: string' ->
      specify 'fails' ->
        expect(-> new ModelPipe 'users').to.throw

    context 'arg: function' ->
      specify 'fails' ->
        expect(-> new ModelPipe (-> 'users')).to.throw

    context 'arg: setter' ->
      specify 'fails' ->
        expect(-> new ModelPipe '_page', 'admins').to.throw

    context 'arg: number' ->
      specify 'fails' ->
        expect(-> new ModelPipe 1).to.throw Error

    context 'admin ModelPipe' ->
      before ->
        pipe := new ModelPipe(admin: {})

      specify 'pipe-type' ->
        expect(pipe.pipe-type).to.eq 'Model'

      describe 'model - attach model pipe' ->
        specify 'no args' ->
          expect(-> pipe.model!).to.throw

        context 'string arg' ->
          before ->
            pipe.model 'user'

          specify 'attached pipe is an a Model pipe' ->
            expect(pipe.child('user').pipe-type).to.eq 'Model'

        specify 'number arg' ->
          expect(-> pipe.model 3).to.throw

        specify 'obj with _clazz arg' ->
          expect(-> pipe.model {_clazz: 'user'}).to.throw

      describe 'model - attach model pipe' ->
        specify 'no args' ->
          expect(-> pipe.attribute!).to.throw

        context 'string arg' ->
          before ->
            pipe.attribute 'user'

          specify 'attached pipe is an Attribute pipe' ->
            expect(pipe.child('user').pipe-type).to.eq 'Attribute'

        specify 'number arg' ->
          expect(-> pipe.attribute 3).to.throw

        specify 'obj with _clazz arg' ->
          expect(-> pipe.attribute {_clazz: 'user'}).to.throw

      describe 'collection - attach collection pipe' ->
        specify 'no args' ->
          expect(-> pipe.collection!).to.throw

        specify 'number arg' ->
          expect(-> pipe.collection 3).to.throw

        specify 'obj with _clazz arg' ->
          expect(-> pipe.collection {_clazz: 'user'}).to.throw

        context 'string arg' ->
          before ->
            pipe.collection 'user'

          context 'attached child pipe' ->
            before ->
              pipes.users := pipe.child('users')

            specify 'child: name was pluralized, so no user pipe' ->
              expect(pipe.child('user').pipe-type).to.be.unknown

            specify 'child: users is an Attribute pipe' ->
              expect(pipes.users.pipe-type).to.eq 'Collection'

            specify 'has name: users' ->
              expect(pipes.users.name).to.eq 'users'

            specify 'has full-name to admin.users' ->
              expect(pipes.users.full-name).to.eq 'admin.users'

            specify '$res is a ResourceCollection' ->
              expect(pipes.users.$res.resource-type).to.eq 'Collection'

    describe 'detach' ->
      context 'child: collection users' ->
        before ->
          pipe := new ModelPipe(admin: {})
          pipes.users = pipe.collection('user')
          pipes.users.detach!

        specify 'collection returns the parent Model pipe' ->
          expect(pipes.users.pipe-type).to.eq 'Collection'

        specify 'full-name reset to users' ->
          expect(pipes.users.full-name).to.eq 'users'

        specify 'parent is void' ->
          expect(pipes.users.parent).to.be.undefined

    describe 'attach an current: user model' ->
      before ->
        pipes.users = pipe.collection('user')

        specify 'pipe-type is Model' ->
          expect(pipes.users.pipe-type).to.eq 'Collection'

        specify 'full-name is admin' ->
          expect(pipes.users.full-name).to.eq 'users'

        specify '$res is a ResourceModel' ->
          expect(pipes.users.$res.resource-type).to.eq 'Collection'

      context 'add model current: user to users collection' ->
        before ->
          pipes.admin-user = pipes.users.model(current: {_clazz: 'user', id: 2})

        context 'current user pipe' ->
          specify 'pipe-type is Model' ->
            expect(pipes.admin-user.pipe-type).to.eq 'Model'

          specify 'full-name is admin.users.current' ->
            expect(pipes.admin-user.full-name).to.eq 'admin.users.current'

          specify '$res is a ResourceModel' ->
            expect(pipes.users.$res.resource-type).to.eq 'Collection'

    describe 'model' ->
      var model, attributes, user

      context 'a user model' ->
        var user-model, proj-model, project

        before ->
          user :=
            name: 'Kris'
            _clazz: 'user'

          project :=
            name: 'My project'
            _clazz: 'project'

          user-model := new ModelPipe user: user

          proj-model := user-model.model project: project

        describe 'model to add project model attribute' ->
          specify 'is a project model' ->
            expect(proj-model).to.be.an.instance-of ModelPipe

          specify 'adds project model as project child of user model ' ->
            expect(user-model.child 'project').to.eq proj-model

    describe 'models' ->
      var model, attributes, user

      context 'a user model' ->
        before ->
          user :=
            name: 'Kris'
            _clazz: 'user'

          model := new ModelPipe user: {}

    describe 'attributes' ->
      var model, attributes, user

      context 'a user model' ->
        before ->
          user :=
            name: 'Kris'
            _clazz: 'user'

          model := new ModelPipe user: {}

        specify 'models returns a AttributesPipeBuilder instance' ->
          expect(model.attributes!).to.be.an.instance-of AttributesPipeBuilder

        context 'PipeAttributes' ->
          before ->
            attributes := model.attributes!

          describe 'add age' ->
            var res
            before ->
              res := attributes.add 'age'

            specify 'returns a AttributesPipeBuilder instance' ->
              expect(res).to.be.an.instance-of AttributesPipeBuilder

            specify 'adds age and status attributes to model' ->
              res.add(status: 'single')
              # console.log attributes.first!
              expect(attributes.first!.name).to.eq 'age'
              expect(attributes.last!.name).to.eq 'status'
