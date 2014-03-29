Class = require('jsclass/src/core').Class

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

expect = require('chai').expect

scoped = {
}

scopify = (orig-fun) ->
  (scope, name, ...items) ->
    fun = scope[name.camelize false]
    orig-fun items.flatten!, (item) ->
       return item if fun.call scope, item

<[map each find filter reject]>.each (fun) ->
  scoped[fun] = scopify lo[fun]

Finder = new Class(
  initialize: ->
    @type = 'x'

  is-x: (item) ->
    console.log 'item', item, @type
    item is @type

  finds: ->
    # scoped.find @, 'is-x', [\y \x \z]
    lo.find [\y \x \z], @is-x, @

  each: ->
    # scoped.each @, 'is-x', [\y \x \z]
    lo.each [\y \x \z], @is-x, @

  map: ->
    # scoped.map @, 'is-x', [\y \x \z]
    lo.map [\y \x \z], @is-x, @
)

describe 'prelude and LiveScript' ->
  var obj, mapped, finder

  before ->
    obj := {x: 2, y: 3}

    keys = _.keys obj

    map-key = (key) ->
      key + '!'

    finder := new Finder

  specify 'finds ok' ->
    expect(finder.finds!).to.eql 'x'

  specify 'each ok' ->
    expect(finder.each!).to.eql [\y \x \z]

  specify 'maps ok' ->
    expect(finder.map!).to.eql [false, true, false]