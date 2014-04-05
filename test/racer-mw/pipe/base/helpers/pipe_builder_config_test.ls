get     = require '../../../../../requires' .get!
expect  = require('chai').expect
_       = require 'prelude-ls'
get.test 'test_setup'

PipeBuilderConfigHelper = get.base-helper 'builder_config'

describe 'PipeBuilderConfigHelperHelper' ->
  describe 'initialize(@name)' ->
    # throw new Error "#{@name} is not a valid child" unless @valid-child name
    # @config-parser!
    specify 'no args - fails' ->
      expect(-> new PipeBuilderConfigHelper).to.throw Error

    specify 'unknown child name: - fails' ->
      expect(-> new PipeBuilderConfigHelper 'unknown').to.throw Error

    specify 'invalid child name: - fails' ->
      expect(-> new PipeBuilderConfigHelper 'collection').to.throw Error

    specify 'valid child name: - ok' ->
      expect(-> new PipeBuilderConfigHelper 'model', ['model']).to.not.throw Error

  context 'instance' ->
    var b-config
    before ->
      b-config := new PipeBuilderConfigHelper 'model', ['model']

    specify 'name is set' ->
      expect(b-config.name).to.eql 'model'

    describe 'config-builder'  ->
      # lo.extend @builders, @builders-for(name)
      specify '..' ->
        # expect(b-config.config-builder!)

    describe 'builders-for(name)' ->
      # @create-config-builder(name).config!
      specify 'returns a model builder' ->
        expect(b-config.builders-for 'model').to.eql 'x'

    describe 'create-config-builder(name)' ->
      # new ConfigBuilder @, name
      specify 'creates a config builder' ->
        expect(b-config.create-config-builder 'models').to.eql 'x'

    describe 'config-parser' ->
      # lo.each @fun-names, @add-parse-fun
      specify 'adds parser functions' ->
        b-config.config-parser!
        expect(b-config.model).to.be.an.instance-of Function

    describe 'fun-names' ->
      # [@name, @aliased-name!].compact!
      specify 'returns function names' ->
        expect(b-config.fun-names!).to.include 'models', 'modls'

    describe 'add-parse-fun(name)' ->
      # @[@fun-name name] = @parser-fun if name
      specify 'returns function names' ->
        b-config.add-parse-fun 'models'
        expect(b-config.models).to.be.an.instance-of Function

    describe 'aliased-name' ->
      # @alias[name]
      specify 'returns function names' ->
        expect(b-config.aliased-name!).to.eql 'modl'

    describe 'fun-name(name)' ->
      # "parse#{name.camelize false}"
      specify 'returns function names' ->
        expect(b-config.fun-name 'models').to.eql 'parseModels'

    describe 'parser-fun(...args)' ->
      # @[name]!.parse ...args
      specify 'parses args' ->
        # expect(b-config.parser-fun x: 2).to.be.an.instance-of AttributeModel

    describe 'alias' ->
      # attributes: 'attrs'
      # collections: 'cols'
      # models: 'modls'
      specify 'returns aliases' ->
        expect(b-config.alias.attributes).to.eql 'attrs'

    describe 'valid-child(name)' ->