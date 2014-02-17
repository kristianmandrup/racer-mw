Module      = require('jsclass/src/core').Module

requires    = require '../../requires'
lo          = require 'lodash'
_           = require 'prelude-ls'


# Array methods
# Array methods can only be used on paths set to arrays, null, or undefined.
# If the path is null or undefined, the path will first be set to an empty
# array before applying the method.
String = Module(

  # model.stringInsert ( path, index, text, [callback] )
  insert: (index, text, cb) ->
    @perform 'stringInsert', subpath, index, text, cb

  # model.stringRemove ( path, index, howMany, [callback] )
  remove: (index, howMany, cb) ->
    @perform 'stringRemove', subpath, index, howMany, cb
)