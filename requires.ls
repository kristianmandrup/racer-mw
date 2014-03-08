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

  apipe-builder: (name) ->
    @pipe('builder', "#{name}_builder")

  apipe-extractor: (name) ->
    @pipe('extractor', "#{name}_extractor")

  apipe: (name) ->
    @lib('pipe', "#{name}_pipe")

  pipe: (...paths) ->
    @lib('pipe', ...paths)

  aresource: (name) ->
    @lib('resource', "#{name}_resource")

  resource: (...paths) ->
    @lib('resource', ...paths)

  file: (path) ->
    require full-path('.', path)
