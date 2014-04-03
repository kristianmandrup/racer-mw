requires = require '../requires'

requires.test 'test_setup'

expect = require('chai').expect

# get = requires.file 'get'

PathMaker = requires.file 'path_maker'

Class       = require('jsclass/src/core').Class

Xyz = new Class(
  initialize: (@b) ->
    @

  go: ->
    @there!

  there: ->
    'there'

)

describe 'Xyz' ->
  var x

  describe 'path-maker' ->
    before ->
      x := new Xyz 'x'

    specify 'can go' ->
      expect(x.go!).to.be.ok

describe 'PathMaker' ->
  var path-maker

  describe 'path-maker' ->
    before ->
      path-maker := new PathMaker 'x'

    specify 'yes' ->
      expect(path-maker.flat-paths!).to.eql ['x']
