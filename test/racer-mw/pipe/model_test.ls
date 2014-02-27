requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

ModelPipe  = requires.pipe 'model'

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

      specify 'id undefined until part of collection' ->
        expect(new ModelPipe(obj).id!).to.be.undefined

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

    context 'arg: array' ->
      specify 'fails' ->
        expect(-> new AttributePipe '_page', 'admins').to.throw

    context 'arg: number' ->
      specify 'fails' ->
        expect(-> new AttributePipe 1).to.throw Error

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

          specify 'attached pipe is an Attribute pipe' ->
            expect(pipe.child('user').pipe-type).to.eq 'Attribute'

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

            describe 'detach' ->
              context 'child: collection users' ->
                before ->
                  pipes.users.detach!

                specify 'parent is void' ->
                  expect(pipes.users.full-name).to.eq 'users'

                specify 'full-name reset to users' ->
                  expect(pipes.users.parent).to.be.undefined

            describe 'attach an current: user model' ->
              before ->
                pipes.admin-user = pipes.users.model current: {_clazz:'user', id: 2}

              context 'current user pipe' ->
                specify 'full-name is admin.users.current' ->
                  expect(pipes.admin-user.full-name).to.eq 'admin.users.current'

        specify 'number arg' ->
          expect(-> pipe.collection 3).to.throw

        specify 'obj with _clazz arg' ->
          expect(-> pipe.collection {_clazz: 'user'}).to.throw
