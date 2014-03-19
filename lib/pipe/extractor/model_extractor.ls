_   = require 'prelude-ls'
lo  = require 'lodash'

module.exports =
  name: (obj) ->
    _name = obj if _.is-type 'String', obj
    if _.is-type 'Object', obj
      return void if obj._clazz isnt void
      _name = _.keys(obj).first!
    @normalized _name

  value: (obj) ->
    # console.log 'value', obj
    return {} if _.is-type 'String', obj
    if _.is-type 'Object', obj
      inner-obj = obj[@name(obj)]
      return inner-obj
    throw new Error "Unable to extract value from: #{obj} #{typeof! obj}"

  clazz: (obj, nested) ->
    unless nested
      return obj if _.is-type 'String', obj

    if _.is-type('Object', obj)
      return @normalized(obj._clazz) if _.is-type('String', obj._clazz)
      inner-obj = obj[@name(obj)]
      @clazz(inner-obj, true) if inner-obj

  normalized: (val) ->
    return void if lo.is-empty val
    val
