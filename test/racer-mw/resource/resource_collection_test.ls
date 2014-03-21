Class    = require('jsclass/src/core').Class
requires = require '../../../requires'

requires.test 'test_setup'

requires = require '../../../requires'

CollectionResource   = requires.aresource 'collection'
CollectionPipe       = requires.apipe     'collection'

expect        = require('chai').expect

describe 'CollectionResource' ->
  var model-res, pipe

  describe 'init' ->
    context 'no args' ->
      specify 'fails - no context' ->
        expect(-> new CollectionResource).to.throw

  context 'a base resource' ->
    before ->
      pipe      := new CollectionPipe 'users'
      model-res := new CollectionResource pipe: pipe

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
