_ = require 'prelude-ls'

expect = require('chai').expect

describe 'prelude and LiveScript' ->
  var obj, mapped

  before ->
    obj := {x: 2, y: 3}

    keys = _.keys obj

    map-key = (key) ->
      key + '!'

    mapped := _.map map-key, keys

  specify 'maps ok' ->
    expect(mapped).to.include \x! \y!