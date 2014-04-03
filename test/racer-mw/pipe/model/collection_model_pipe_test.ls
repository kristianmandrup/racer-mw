Class       = require('jsclass/src/core').Class
get = require '../../../requires' .get!
_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

CollectionModelPipe  = get.model 'container_model'

describe 'CollectionModelPipe' ->
  var col-pipe

  describe 'initialize(item)' ->
    specify 'no args - fails' ->
      expect(-> new CollectionModelPipe).to.throw Error

    specify 'String arg - ok' ->
      expect(-> new CollectionModelPipe 'x').to.not.throw Error

  context 'instance' ->
    before ->
      col-pipe := new CollectionModelPipe 'x'

    context 'pipe' ->
      var pipe

      before ->
        pipe := col-pipe.pipe

      describe 'type' ->
        specify 'is Collection' ->
          expect(pipe.type).to.eql 'Collection'

      describe 'container' ->
        specify 'is true' ->
          expect(pipe.container).to.be.true

      describe 'pipe.child' ->
        specify 'is true' ->
          expect(pipe.child).to.be.true

      describe 'pipe.kind' ->
        specify 'is Model' ->
          expect(pipe.kind).to.eql 'Model'

    describe 'id' ->
      # String(@object-id) unless @object-id is void
      specify 'is void when not in Collection' ->
        expect(col-pipe.id!).to.eql void

    describe 'pre-attach-to(parent)' ->
      # @call-super!
      # @attacher!.attach-to parent
      specify 'is void when not in Collection' ->
        expect(col-pipe.id!).to.eql void


    describe 'attacher' ->
      # new ParentAttacher @

    describe 'valid-parents' ->
      # <[path collection]>

    describe 'valid-children' ->
      # <[attribute model-attribute collection]>