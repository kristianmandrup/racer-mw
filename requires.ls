require 'sugar'
_   = require 'prelude-ls'

underscore = (...items) ->
  items = items.flatten!
  strings = items.map (item) ->
    String(item)
  _.map (.underscore!), strings

full-path = (base, ...paths) ->
  upaths = underscore(...paths)
  ['.', base, upaths].flatten!.join '/'


# TODO: Clean Up!!!

test-path = (...paths) ->
  full-path 'test', ...paths

lib-path = (...paths) ->
  full-path 'lib', ...paths

module.exports =
  test: (...paths) ->
    require test-path(...paths)

  lib: (...paths) ->
    require lib-path(...paths)

  mw: (...paths) ->
    @lib('mw', ...paths)

  racer: (...paths) ->
    @lib('racer', ...paths)

  error: (...paths) ->
    @lib('errors', ...paths)

  pipe-builder: (...paths) ->
    @lib('pipe', 'builder', ...paths)

  pipe: (...paths) ->
    @lib('pipe', ...paths)

  resource: (...paths) ->
    @lib('resource', ...paths)

  file: (path) ->
    require full-path('.', path)
