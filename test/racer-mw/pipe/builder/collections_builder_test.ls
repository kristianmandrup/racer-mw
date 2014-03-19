requires = require '../../../../requires'

requires.test 'test_setup'

expect            = require('chai').expect

CollectionsPipeBuilder = requires.apipe-builder 'collections'

ModelPipe         = requires.apipe 'model'
AttributePipe     = requires.apipe 'attribute'
PathPipe          = requires.apipe 'path'
CollectionPipe    = requires.apipe 'collection'

describe 'CollectionsPipeBuilder' ->
  var collections, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take a value' ->
        expect(-> new CollectionsPipeBuilder).to.throw Error

    context 'arg: AttributePipe' ->
      var attr-pipe

      before ->
        attr-pipe := new AttributePipe 'name'

      specify 'invalid container - fails' ->
        expect(-> new CollectionsPipeBuilder attr-pipe).to.throw Error

    context 'arg: PathPipe' ->
      var path-pipe

      before ->
        path-pipe := new PathPipe 'name'

      specify 'valid container' ->
        expect(-> new CollectionsPipeBuilder path-pipe).to.not.throw

    context 'arg: ModelPipe' ->
      var model-pipe

      before ->
        model-pipe := new ModelPipe name: {}

      specify 'valid container' ->
        expect(-> new CollectionsPipeBuilder model-pipe).to.not.throw

    context 'arg: CollectionPipe' ->
      var col-pipe

      before ->
        col-pipe := new CollectionPipe 'name'

      specify 'invalid container - fails' ->
        expect(-> new CollectionsPipeBuilder col-pipe).to.throw Error

    context 'ModelPipe with collections' ->
      var modl-pipe

      before ->
        modl-pipe    := new ModelPipe 'user'
        collections  := new CollectionsPipeBuilder modl-pipe

      specify 'is a CollectionsPipeBuilder' ->
        expect(collections).to.be.an.instance-of CollectionsPipeBuilder

    context 'PathPipe with collections' ->
      var path-pipe

      before ->
        path-pipe    := new PathPipe '_page'
        collections  := new CollectionsPipeBuilder path-pipe

      specify 'is a CollectionsPipeBuilder' ->
        expect(collections).to.be.an.instance-of CollectionsPipeBuilder
