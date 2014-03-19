requires = require '../../../../requires'

requires.test 'test_setup'

expect            = require('chai').expect

ModelPipe         = requires.apipe         'model'
ConfigBuilder     = requires.apipe-builder 'config'

ModelsPipeBuilder = requires.apipe-builder 'models'
ModelPipeBuilder  = requires.apipe-builder 'model'

describe 'ConfigBuilder' ->
  var cb, pipe

  before ->
    pipe := new ModelPipe 'user'

  describe 'init' ->
    specify 'no args - fails' ->
      expect(-> new ConfigBuilder).to.throw Error

    specify 'only name arg - fails' ->
      expect(-> new ConfigBuilder 'hello').to.throw Error

    specify 'name and clazz name - fails' ->
      expect(-> new ConfigBuilder 'hello', clazz: 'model').to.throw Error

    context 'name and constructor' ->
      before ->
        cb := new ConfigBuilder pipe, 'user', clazz: ModelPipeBuilder

      specify 'creates ConfigBuilder' ->
        expect(cb).to.be.an.instance-of ConfigBuilder

      specify 'with name set' ->
        expect(cb.name).to.eql 'user'

      specify 'and clazz set' ->
        expect(cb.clazz).to.eql ModelPipeBuilder

      specify 'multi-clazz not set' ->
        expect(cb.multi-clazz).to.be.undefined

      describe 'single-config' ->
        specify 'with clazz returns self' ->
          expect(cb.single-config!).to.eq cb

        context 'config' ->
          before ->
            cb.single-config!

          specify 'adds singular builder to repo' ->
            expect(cb.builders['user']).to.be.an.instance-of ModelPipeBuilder

          specify 'builder(user) retrieves builder' ->
            expect(cb.builder 'user').to.be.an.instance-of ModelPipeBuilder

      describe 'multi-config' ->
        specify 'without multi-clazz returns void' ->
          expect(cb.multi-clazz).to.be.undefined

        context 'set multi-clazz' ->
          before ->
            cb := new ConfigBuilder pipe, 'user', clazz: ModelPipeBuilder, multi-clazz: ModelsPipeBuilder

          specify 'with multi-clazz does not return void' ->
            expect(cb.multi-clazz).to.not.be.undefined

          specify 'with multi-clazz returns self' ->
            expect(cb.multi-config!).to.eq cb

          context 'multi-config' ->
            before ->
              cb.multi-config!

            specify 'adds plural builders to repo' ->
              expect(cb.builders['users']).to.be.an.instance-of ModelsPipeBuilder

            specify 'builder(users) retrieves builder' ->
              expect(cb.builder 'users').to.be.an.instance-of ModelsPipeBuilder

      describe 'config' ->
        context 'with clazzes configured' ->
          var res
          before ->
            cb := new ConfigBuilder pipe, 'user', clazz: ModelPipeBuilder, multi-clazz: ModelsPipeBuilder
            res := cb.config!

          specify 'result is repo with user' ->
            expect(res.user).to.be.an.instance-of ModelPipeBuilder

          specify 'and users' ->
            expect(res.users).to.be.an.instance-of ModelsPipeBuilder

          specify 'adds singular builder to repo' ->
            expect(cb.builder 'user' ).to.be.an.instance-of ModelPipeBuilder

          specify 'adds plural builders to repo' ->
            expect(cb.builders['users']).to.be.an.instance-of ModelsPipeBuilder
