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

# How do we authorize all these operations?
# We need to group them

# - get/query/filter = read
# - update list/set = update
# - delete
# - add/create = create

UpdateList = Class(RacerSync,
  initialize (@path) ->

  # length = model.push ( path, value, [callback] )
  push: (value, cb) ->
    @perform 'push' value, cb

  # length = model.unshift ( path, value, [callback] )

  # authorize container and value if Document
  # validate container and value if Document
  # marshal value (simple or Document)
  unshift: (value, cb) ->
    @perform 'unshift', value, cb

  # length = model.insert ( path, index, values, [callback] )

  # authorize container and value if Document
  # validate container and value if Document
  # marshal value (simple or Document)
  insert: (index, values, cb) ->
    @perform 'insert', value, cb

  # length = model.insert ( path, index, values, [callback] )

  # authorize container and value if Document (Delete, Read)
  # decorate popped value
  pop: (cb) ->
    @perform 'pop', cb

  # item = model.shift ( path, [callback] )

  # authorize container, Update
  shift: (cb) ->
    @perform 'shift', cb

  # removed = model.remove ( path, index, [howMany], [callback] )
  # authorize container, Delete
  remove: (index, opts) ->
    if opts
      how-many = opts['how-many']
      cb       = opts['cb']

    if how-many and how-many > 0
      @perform 'remove', index, how-many, cb
    else
      @perform 'remove', index, cb

  # moved = model.move ( path, from, to, [howMany], [callback] )
  # authorize container, Update
  move: (ifrom, ito, opts) ->
    if opts
      how-many = opts['how-many']
      cb       = opts['cb']

    if how-many and how-many > 0
      @perform 'move', ifrom, ito, how-many, cb
    else
      @perform 'move', ifrom, ito, cb

)