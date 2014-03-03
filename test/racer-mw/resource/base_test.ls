Class    = require('jsclass/src/core').Class
requires = require '../../../requires'

requires.test 'test_setup'

requires = require '../../../requires'

BaseResource   = requires.resource 'base'

expect        = require('chai').expect

describe 'BaseResource' ->
  var base-res

  describe 'init' ->
    context 'no args' ->
      specify 'creates it' ->
        expect(-> new BaseResource).to.not.throw

  context 'a base resource' ->
    before ->
      base-res := new BaseResource

    specify 'has a function scoped' ->
      expect(base-res.scoped).to.be.an.instance-of Function

    specify 'has a function save' ->
      expect(base-res.save).to.be.an.instance-of Function

    specify 'has a function at' ->
      expect(base-res.at).to.be.an.instance-of Function

    specify 'resource-type is Base' ->
      expect(base-res.resource-type).to.eq 'Base'
