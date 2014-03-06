Class    = require('jsclass/src/core').Class
requires = require '../../../requires'

requires.test 'test_setup'

requires = require '../../../requires'

BaseResource   = requires.resource 'base'

expect        = require('chai').expect

CollectionPipe    = requires.pipe 'collection'
ModelPipe         = requires.pipe 'model'
AttributePipe     = requires.pipe 'attribute'

describe 'BaseResource' ->
  var base-res

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take context' ->
        expect(-> new BaseResource).to.throw

  context 'a base resource' ->
    before ->
      base-res := new BaseResource {}

    specify 'has a function scoped' ->
      expect(base-res.scoped).to.be.an.instance-of Function

    specify 'has a function save' ->
      expect(base-res.save).to.be.an.instance-of Function

    specify 'has a function at' ->
      expect(base-res.at).to.be.an.instance-of Function

    specify 'resource-type is Base' ->
      expect(base-res.resource-type).to.eq 'Base'

    describe 'config-pipe' ->
      specify 'does nothing when no pipe' ->
        base-res.config-pipe!
        expect(base-res.pipe).to.be.undefined

      specify 'configures a pipe' ->
        pipe = new ModelPipe(user: {})
        base-res.config-pipe pipe
        expect(base-res.pipe).to.eq pipe

    describe 'detach' ->
      specify 'detaches from pipe' ->
        base-res.detach!
        expect(base-res.pipe).to.be.undefined

    describe 'value-object' ->
      specify 'has none' ->
        expect(-> base-res.value-object!).to.throw

    describe 'set value-object directly' ->
      before ->
        base-res := new BaseResource value: 27

      specify 'is 27' ->
        expect(base-res.value-object!).to.eq 27

    describe 'obtain value-object from Model Pipe' ->
      var user
      before ->
        user := {name: 'Kris'}
        pipe = new ModelPipe(user: user)
        base-res := new BaseResource pipe: pipe

      specify 'is an object with name: Kris' ->
        expect(base-res.value-object!).to.eq user

    describe 'obtain value-object from Attribute Pipe' ->
      var user
      before ->
        pipe = new AttributePipe(user: 27)
        base-res := new BaseResource pipe: pipe

      specify 'is 27' ->
        expect(base-res.value-object!).to.eq 27

    describe 'obtain Array value-object from Attribute Pipe' ->
      var user
      before ->
        pipe = new AttributePipe(list: [1,2,3])
        base-res := new BaseResource pipe: pipe

      specify 'is a list of numbers' ->
        expect(base-res.value-object!).to.include(1,2,3)

    describe 'obtain Array value-object from Collection Pipe' ->
      var user
      before ->
        user := {_clazz: 'user', name: 'Kris'}
        # TODO: should implicitly assume model added is a 'user' class if no _clazz in value object!
        pipe = new CollectionPipe('users')
        pipe.models!.add(user)
        base-res := new BaseResource pipe: pipe

      specify 'is a list of numbers' ->
        expect(base-res.value-object!.first!).to.eq user
