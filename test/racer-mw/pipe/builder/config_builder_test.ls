requires = require '../../../../requires'

requires.test 'test_setup'

expect            = require('chai').expect

ConfigBuilder     = requires.apipe-builder 'config'

ModelsPipeBuilder = requires.apipe-builder 'models'

describe 'ConfigBuilder' ->
  var cb

  describe 'init' ->
    specify 'no args - fails' ->
      expect(-> new ConfigBuilder).to.throw Error

    specify 'only name arg - fails' ->
      expect(-> new ConfigBuilder 'hello').to.throw Error

    specify 'name and clazz name - fails' ->
      expect(-> new ConfigBuilder 'hello', 'model').to.throw Error

    context 'name and constructor' ->
      before ->
        cb := new ConfigBuilder 'hello', ModelsPipeBuilder

      specify 'creates ConfigBuilder' ->
        expect(cb).to.be.an.instance-of ConfigBuilder

      specify 'with name set' ->
        expect(cb.name).to.eql 'hello'

      specify 'and clazz set' ->
        expect(cb.clazz).to.eql ModelsPipeBuilder


  describe 'config' ->


  describe 'multi-config' ->

  describe 'builder(name)' ->
