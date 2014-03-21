Class    = require('jsclass/src/core').Class
requires = require '../../../requires'

requires.test 'test_setup'

requires = require '../../../requires'

ModelResource   = requires.aresource 'model'
ModelPipe       = requires.apipe     'model'

expect        = require('chai').expect

describe 'ModelResource' ->
  var model-res, pipe

  describe 'init' ->
    context 'no args' ->
      specify 'fails - no context' ->
        expect(-> new ModelResource).to.throw

  context 'a base resource' ->
    before ->
      pipe      := new ModelPipe 'user'
      model-res := new ModelResource pipe

    specify 'has a function scoped' ->
      expect(model-res.scoped).to.be.an.instance-of Function

    specify 'has a function save' ->
      expect(model-res.save).to.be.an.instance-of Function

    specify 'has a function filter' ->
      expect(model-res.filter).to.be.an.instance-of Function

    specify 'has a function sort' ->
      expect(model-res.sort).to.be.an.instance-of Function

    specify 'has a function query' ->
      expect(model-res.query).to.be.an.instance-of Function
