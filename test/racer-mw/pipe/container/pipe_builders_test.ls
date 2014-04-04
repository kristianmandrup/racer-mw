Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeBuilders    = requires.pipe 'pipe_builders'

AttributePipe     = requires.apipe 'attribute'
ModelPipe         = requires.apipe 'model'
PathPipe          = requires.apipe 'path'
CollectionPipe    = requires.apipe 'collection'

SimpleObj = new Class(
)


NoAttachPipe = new Class(
  include: PipeBuilders

  initialize: ->
    @

  attach: void
)


AllPipe = new Class(
  include: PipeBuilders

  initialize: ->
    @

  attach: ->

  valid-children:
    * \attribute
    * \model
    * \collection

  type: 'Pipe'
  pipe-type: 'Path'

  describe: ->
    'I am All'
)

describe 'PipeBuilders' ->
  var pipe, obj

  context 'SimpleObj' ->
    before ->
      pipe := new SimpleObj

    describe 'config-builders function' ->
      specify 'is not present' ->
        expect(pipe.config-builders).to.be.undefined

  context 'NoAttachPipe' ->
    before ->
      pipe := new NoAttachPipe

    describe 'config-builders function' ->
      specify 'is present' ->
        expect(pipe.config-builders).to.not.be.undefined

      specify 'returns void' ->
        expect(pipe.config-builders!).to.eq void


  context 'AllPipe' ->
    before ->
      pipe := new AllPipe

    describe 'config-builders function' ->
      specify 'is present' ->
        expect(pipe.config-builders).to.not.be.undefined

      specify 'returns self' ->
        expect(pipe.config-builders!).to.eq pipe

    context 'configured builders' ->
      before ->
        pipe.config-builders!

      specify 'builders contain the builders' ->
        expect(pipe.builders).to.not.be.empty

      specify 'builders contain the right builder' ->
        expect(pipe.builder-names!).to.include 'model', 'models', 'collection', 'collections', 'attribute', 'attributes'

  context 'CollectionPipe' ->
    before ->
      pipe := new CollectionPipe 'users'
      pipe.config-builders!

    specify 'builders contain model, models' ->
      expect(pipe.builder-names!).to.include 'model', 'models'

  context 'ModelPipe' ->
    before ->
      pipe := new ModelPipe 'admin'
      pipe.config-builders!

    specify 'builders contain all' ->
      expect(pipe.builder-names!).to.include 'model', 'models', 'collection', 'collections', 'attribute', 'attributes'

  context 'PathPipe' ->
    before ->
      pipe := new PathPipe '_page'
      pipe.config-builders!

    specify 'builders contain all' ->
      expect(pipe.builder-names!).to.include 'model', 'models', 'collection', 'collections', 'attribute', 'attributes'

  context 'AttributePipe' ->
    before ->
      pipe := new AttributePipe 'name'
      pipe.config-builders!

    specify 'builders contain none' ->
      expect(pipe.builder-names!).to.be.empty
