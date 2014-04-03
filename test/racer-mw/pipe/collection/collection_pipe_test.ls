requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

CollectionPipe  = requires.d.pipe 'collection'
ModelPipe       = requires.d.pipe 'model'
PathPipe        = requires.d.pipe 'path'

ModelsPipeBuilder  = requires.d.pipe-builder     'models'

describe 'CollectionPipe' ->
  var pipe, obj, collection
  var models, user

  pipes = {}

  context 'Pipe: parentless users' ->
    before ->
      pipes.users := new CollectionPipe 'users'

    describe 'children' ->
      specify 'none' ->
        expect(pipes.users.children).to.be.empty

    describe 'parent' ->
      specify 'is void' ->
        expect(pipes.users.parent).to.be.undefined

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new CollectionPipe).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails' ->
        expect(-> new CollectionPipe obj).to.throw

    context 'arg: object with _clazz' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'creates it' ->
        expect(new CollectionPipe obj).to.be.an.instance-of CollectionPipe

      specify 'sets name to users' ->
        expect(new CollectionPipe(obj).name).to.eq 'users'

    context 'arg: string' ->
      specify 'creates it' ->
        expect(new CollectionPipe 'users').to.be.an.instance-of CollectionPipe

      specify 'sets name to users' ->
        expect(new CollectionPipe('users').name).to.eq 'users'

    context 'arg: function' ->
      specify 'creates it' ->
        expect(-> new CollectionPipe (-> 'users')).to.not.throw

      specify 'creates it' ->
        expect(new CollectionPipe 'users').to.be.an.instance-of CollectionPipe

    context 'list of strings' ->
      specify 'does not fail' ->
        expect(-> new CollectionPipe '_page', 'admins').to.not.throw

      describe '_page admins' ->
        before ->
          pipes.page-admins := new CollectionPipe '_page', 'admins'

        specify 'creates it (with a Path parent)' ->
          expect(pipes.page-admins).to.be.an.instance-of CollectionPipe

        specify 'name is admins' ->
          expect(pipes.page-admins.name).to.be.eq 'admins'

        specify 'parent is Path pipe' ->
          expect(pipes.page-admins.parent).to.be.an.instance-of PathPipe

        specify 'parent Path pipe has name _page' ->
          expect(pipes.page-admins.parent.name).to.eq '_page'

    context 'arg: number' ->
      specify 'fails' ->
        expect(-> new CollectionPipe 1).to.throw Error

    describe 'model' ->
      context 'a users collection' ->
        var mdl

        before ->
          collection := new CollectionPipe 'users'
          mdl := collection.model(_clazz: 'user', name: 'kris')

        specify 'model adds ModelPipe as child' ->
          expect(mdl).to.be.an.instance-of ModelPipe

    describe 'models' ->
      context 'a users collection' ->
        before ->
          collection := new CollectionPipe 'users'

        specify 'models returns a PipeModels instance' ->
          expect(collection.models!).to.be.an.instance-of ModelsPipeBuilder

        context 'PipeModels' ->
          before ->
            models := collection.models!
            user :=
              name: 'Kris'
              _clazz: 'user'

          describe 'add a user' ->
            var res, added
            before ->
              collection.clear!
              models.clear!
              res := models.add user
              added := models.added.first!
              # console.log added

            specify 'returns a PipeModels instance' ->
              expect(res).to.be.an.instance-of ModelsPipeBuilder

            specify 'adds user to collection' ->
              expect(added.name).to.eq 'user'

            specify 'user added is a ModelPipe' ->
              expect(added).to.be.an.instance-of ModelPipe

            specify 'user added has id function' ->
              expect(added.id).to.not.be.undefined

            specify 'adds user 0 to collection' ->
              expect(added.id!).to.eq '0'
