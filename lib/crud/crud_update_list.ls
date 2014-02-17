Module      = require('jsclass/src/core').Module

requires    = require '../../requires'
lo          = require 'lodash'
_           = require 'prelude-ls'


# Array methods
# Array methods can only be used on paths set to arrays, null, or undefined.
# If the path is null or undefined, the path will first be set to an empty
# array before applying the method.

# Think about how to do this the right way!
# Where does it makes sense to use perform? where not?
# How to improve? Fx, for some methods no object(s) are passed to perform, for others there are
# Should we move methods to other classes? Hmm...

UpdateList = Class(
  initialize (@path) ->

  # length = model.push ( path, value, [callback] )
  push: (value, cb) ->
    @perform 'push' value, cb

  # length = model.unshift ( path, value, [callback] )
  unshift: (value, cb) ->
    @perform 'unshift', value, cb

  # length = model.insert ( path, index, values, [callback] )
  insert: (index, values, cb) ->
    @perform 'insert', value, cb

  # length = model.insert ( path, index, values, [callback] )
  pop: (cb) ->
    @perform 'pop', cb

  # item = model.shift ( path, [callback] )
  shift: (cb) ->
    @perform 'shift', cb

  # removed = model.remove ( path, index, [howMany], [callback] )
  remove: (index, opts) ->
    if opts
      how-many = opts['how-many']
      cb       = opts['cb']

    if how-many and how-many > 0
      @perform 'remove', index, how-many, cb
    else
      @perform 'remove', index, cb

  # moved = model.move ( path, from, to, [howMany], [callback] )
  move: (ifrom, ito, opts) ->
    if opts
      how-many = opts['how-many']
      cb       = opts['cb']

    if how-many and how-many > 0
      @perform 'move', ifrom, ito, how-many, cb
    else
      @perform 'move', ifrom, ito, cb

)