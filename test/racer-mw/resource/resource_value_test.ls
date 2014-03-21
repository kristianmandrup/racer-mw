Class    = require('jsclass/src/core').Class
requires = require '../../../requires'

requires.test 'test_setup'

expect        = require('chai').expect

requires = require '../../../requires'

BaseResource        = requires.aresource 'base'
ModelResource       = requires.aresource 'model'
AttributeResource   = requires.aresource 'attribute'
CollectionResource  = requires.aresource 'collection'

BasePipe          = requires.apipe 'base'
CollectionPipe    = requires.apipe 'collection'
ModelPipe         = requires.apipe 'model'
AttributePipe     = requires.apipe 'attribute'
PathPipe          = requires.apipe 'path'

describe 'ResourceValue' ->
  var base-res, model-res, att-res, col-res, pipe
  var user

  before ->
    user := {name: 'Kris'}

  context 'transfer pipe value' ->
    before ->
      pipe := new ModelPipe(user: {})
      model-res := new ModelResource pipe: pipe
      model-res.attach-to pipe
      model-res.detach transfer: true

    describe 'value-object' ->
      specify 'has none' ->
        expect(-> base-res.value!).to.throw

    describe 'set value-object directly' ->
      before ->
        base-res := new BaseResource value: 27

      specify 'is 27' ->
        expect(base-res.value!).to.eq 27

  describe 'obtain value-object from Model Pipe' ->
    before ->
      pipe := new ModelPipe(user: user)
      model-res := new ModelResource pipe: pipe, transfer: true

    specify 'is an object with name: Kris' ->
      expect(model-res.value-obj.value).to.eq pipe.value-obj.value

    specify 'is an object with name: Kris' ->
      expect(model-res.value!).to.eq user

    describe 'obtain value-object from Attribute Pipe' ->
      before ->
        pipe = new AttributePipe(user: 27)
        att-res := new AttributeResource pipe: pipe

      specify 'is not 27 since no explicit transfer' ->
        expect(att-res.value!).to.not.eq 27

    describe 'obtain Array value-object from Attribute Pipe' ->
      before ->
        pipe = new AttributePipe(list: [1,2,3])
        att-res := new AttributeResource pipe: pipe, transfer: true

      specify 'is a list of numbers (transferred)' ->
        expect(att-res.value!).to.include(1,2,3)

  describe 'obtain Array value-object from Collection Pipe' ->
    before ->
      user := {_clazz: 'user', name: 'Kris'}

      col-pipe = new CollectionPipe('users')
      # should update col-pipe with [user] in raw-value linked to value-object
      col-pipe.models!.add(user)
      console.log 'value', col-pipe.value!, col-pipe.raw-value!
      col-res := new CollectionResource pipe: col-pipe, transfer: true

    specify.only 'and get first user' ->
      console.log col-res.value!
      expect(col-res.value!.first!).to.eq user