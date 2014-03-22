requires = require '../../../../requires'

requires.test 'test_setup'

BasePipe          = requires.apipe 'base'
PipeValidator     = requires.pipe 'validator/pipe_validator'

CollectionPipe    = requires.apipe 'collection'
ModelPipe         = requires.apipe 'model'
AttributePipe     = requires.apipe 'attribute'
PathPipe          = requires.apipe 'path'

expect      = require('chai').expect

describe 'PipeValidator' ->
  var modl-pipe, pipe

  before ->
    modl-pipe := {pipe-type: 'model'}
    pipe      := {pipe-type: 'model', type: 'Pipe'}

  # (@obj, @valid-types = [])
  describe 'initialize' ->
    specify 'no args: fails' ->
      expect(-> new PipeValidator).to.throw Error

    specify 'string arg: fails' ->
      expect(-> new PipeValidator 'x').to.throw Error

    # @is-obj!
    specify 'object arg: ok' ->
      expect(-> new PipeValidator {}).to.not.throw Error

    specify 'array arg: ok' ->
      expect(-> new PipeValidator []).to.not.throw Error

    # @pipe-type = @obj.pipe-type
    specify 'sets pipe-type' ->
      expect(new PipeValidator(modl-pipe).pipe-type).to.equal 'model'

    # @pipe-type = @obj.pipe-type
    specify 'does not set pipe-type when array' ->
      expect(new PipeValidator([]).pipe-type).to.be.undefined

  # Must be an Object or Array
  describe 'is-obj' ->
    specify 'object is an object' ->
      expect(new PipeValidator(modl-pipe).is-obj!).to.be.ok

    specify 'array is an object' ->
      expect(new PipeValidator([]).is-obj!).to.be.ok

  # Must be a type: Pipe
  describe 'is-pipe' ->
    specify 'empty obj: fails' ->
      expect(-> new PipeValidator({}).is-pipe!).to.throw Error

    specify 'pipe-type: model without type: Pipe is not a Pipe' ->
      expect(-> new PipeValidator(modl-pipe).is-pipe!).to.throw Error

    specify 'array is not a Pipe' ->
      expect(-> new PipeValidator([]).is-pipe!).to.throw Error

    specify 'type: Pipe is not a Pipe without pipe-type' ->
      expect(-> new PipeValidator(miss-type-pipe).is-pipe!).to.throw Error

    specify 'type: Pipe with pipe-type is a Pipe' ->
      expect(-> new PipeValidator(pipe).is-pipe!).to.not.throw Error

  describe 'validate' ->
    specify 'model is valid when no valid-types' ->
      expect(-> new PipeValidator(pipe).validate!).to.not.throw Error

    specify 'CollectionPipe is valid' ->
      expect(-> new PipeValidator(new CollectionPipe('users')).validate!).to.not.throw Error

    specify 'ModelPipe is valid' ->
      expect(-> new PipeValidator(new ModelPipe('user')).validate!).to.not.throw Error

    specify 'AttributePipe is valid' ->
      expect(-> new PipeValidator(new AttributePipe('name')).validate!).to.not.throw Error

    specify 'PathPipe is valid' ->
      expect(-> new PipeValidator(new PathPipe('_page')).validate!).to.not.throw Error

    # @validate-many @obj if typeof! @obj is 'Array'
    specify 'array calls validate-many' ->
      expect(-> new PipeValidator([]).validate!).to.not.throw Error

    # @validate-types!
    specify 'model is not valid when not in valid-types' ->
      expect(-> new PipeValidator(pipe, ['collection']).validate!).to.throw Error

    specify 'model is valid when in valid-types' ->
      expect(-> new PipeValidator(pipe, ['collection', 'model']).validate!).to.not.throw Error




  describe 'validate-many (objs)' ->

  describe 'validate-types' ->
    specify 'model is not valid when not in valid-types' ->
      expect(-> new PipeValidator(pipe, ['collection']).validate-types!).to.throw Error

    specify 'model is valid when in valid-types' ->
      expect(new PipeValidator(pipe, ['collection', 'model']).validate-types!).to.be.ok
