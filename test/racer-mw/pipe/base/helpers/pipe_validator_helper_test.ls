Class   = require('jsclass/src/core').Class
get     = require '../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

PipeValidatorHelper     = get.base-helper 'validator'

BasePipe          = get.apipe 'base'
CollectionPipe    = get.apipe 'collection'
ModelPipe         = get.apipe 'model'
AttributePipe     = get.apipe 'attribute'
PathPipe          = get.apipe 'path'

describe 'PipeValidatorHelper' ->
  var modl-pipe, t-pipe

  describe 'initialize(@obj, @valid-types = [])' ->
    before ->
      modl-pipe :=
        type: 'Pipe'
        info:
          type: 'model'
      t-pipe      :=
        type: 'Pipe'


    specify 'no args: fails' ->
      expect(-> new PipeValidatorHelper).to.throw Error

    specify 'string arg: fails' ->
      expect(-> new PipeValidatorHelper 'x').to.throw Error

    # @is-obj!
    specify 'object arg: fails' ->
      expect(-> new PipeValidatorHelper {}).to.throw Error

    specify 'setter arg: ok' ->
      expect(-> new PipeValidatorHelper []).to.not.throw Error

    specify 'pipe arg - ok' ->
      expect(-> new PipeValidatorHelper modl-pipe).to.not.throw Error

    # @pipe-type = @obj.pipe-type
    specify 'sets pipe-type' ->
      expect(new PipeValidatorHelper(modl-pipe).pipe-type).to.equal 'model'

  context 'model pipe' ->
    var validator

    before ->
      validator := new PipeValidatorHelper(modl-pipe)

    describe 'is-object' ->
      specify 'object is an object' ->
        expect(validator.is-object!).to.be.ok

    describe 'pipe' ->
      specify 'is set' ->
        expect(validator.pipe).to.eq modl-pipe

    xdescribe 'validate' ->
      specify 'model is valid when no valid-types' ->
        expect(-> new PipeValidatorHelper(pipe).validate!).to.not.throw Error

      specify 'CollectionPipe is valid' ->
        expect(-> new PipeValidatorHelper(new CollectionPipe('users')).validate!).to.not.throw Error

      specify 'ModelPipe is valid' ->
        expect(-> new PipeValidatorHelper(new ModelPipe('user')).validate!).to.not.throw Error

      specify 'AttributePipe is valid' ->
        expect(-> new PipeValidatorHelper(new AttributePipe('name')).validate!).to.not.throw Error

      specify 'PathPipe is valid' ->
        expect(-> new PipeValidatorHelper(new PathPipe('_page')).validate!).to.not.throw Error

      # @validate-many @obj if typeof! @obj is 'Array'
      specify 'setter calls validate-many' ->
        expect(-> new PipeValidatorHelper([]).validate!).to.not.throw Error

      # @validate-types!
      specify 'model is not valid when not in valid-types' ->
        expect(-> new PipeValidatorHelper(modl-pipe, ['collection']).validate!).to.throw Error

      specify 'model is valid when in valid-types' ->
        expect(-> new PipeValidatorHelper(modl-pipe, ['collection', 'model']).validate!).to.not.throw Error

    describe 'validate-many (objs)' ->

    describe 'validate-types' ->
      specify 'model is not valid when not in valid-types' ->
        expect(-> new PipeValidatorHelper(modl-pipe, ['collection']).validate-types!).to.throw Error

      specify 'model is valid when in valid-types' ->
        expect(new PipeValidatorHelper(modl-pipe, ['collection', 'model']).validate-types!).to.be.ok
