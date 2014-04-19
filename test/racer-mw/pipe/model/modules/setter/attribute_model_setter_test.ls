Class         = require('jsclass/src/core').Class
get           = require '../../../../../../requires' .get!
expect        = require('chai').expect
get.test 'test_setup'

AttModelSetter  = get.model-setter 'attribute_model'
ModelExtractor  = get.model-extractor 'model'

AttModelPipe = new Class(
  include:
    * AttModelSetter
    ...

  initialize: (@obj) ->
)

describe 'AttributeModelSetter' ->
  var pipe

  describe 'initialize' ->
    specify 'throws' ->
      expect(-> new AttModelPipe).to.not.throw Error

  context 'instance' ->
    before ->
      pipe := new AttModelPipe 'admin'

    describe 'model-extractor' ->
      specify 'is ModelExtractor' ->
        expect(pipe.model-extractor!).to.be.an.instance-of ModelExtractor

    describe 'set-name' ->
      specify 'set clazz' ->
        expect(pipe.set-name!.name).to.eql 'admin'

    describe 'set-clazz' ->
      specify 'set clazz' ->
        expect(pipe.set-clazz!.clazz).to.eql 'admin'

    describe 'set-value' ->
      specify 'set value' ->
        expect(pipe.set-value!.value).to.eql {}

    describe 'model' ->
      specify 'set model' ->
        expect(pipe.model!).to.eql name: 'admin', value: {}, clazz: 'admin'

    describe 'set-all' ->
      before ->
        pipe.set-all!

      specify 'sets name' ->
        expect(pipe.name).to.eql 'admin'

      specify 'sets value' ->
        expect(pipe.value).to.eql {}

      specify 'sets clazz' ->
        expect(pipe.clazz).to.eql 'admin'

      describe 'reset-all' ->
        before ->
          pipe.reset-all!

        specify 'name is reset' ->
          expect(pipe.name).to.eql void

        specify 'value is reset' ->
          expect(pipe.value).to.eql void

        specify 'clazz is reset' ->
          expect(pipe.clazz).to.eql void
