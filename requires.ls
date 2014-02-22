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

mw-path = (...paths) ->
  full-path 'mw', ...paths

model-path = (...paths) ->
  full-path 'models', ...paths

crud-path = (...paths) ->
  full-path 'crud', ...paths

module.exports =
  test: (...paths) ->
    require test-path(...paths)

  mw: (...paths) ->
    require mw-path(...paths)

  model: (...paths) ->
    require model-path(...paths)

  lib: (...paths) ->
    require lib-path(...paths)

  crud: (...paths) ->
    require crud-path(...paths)

  pipe: (...paths) ->
    require crud-path(...paths)

  resource: (...paths) ->
    require resource-path(...paths)

  fixture: (path) ->
    @test 'fixtures', path

  # alias
  fix: (path) ->
    @fixture path

  factory: (path) ->
    @test 'factories', path

  # alias
  fac: (path) ->
    @factory path

  file: (path) ->
    require full-path('.', path)

  # m - alias for module
  m: (path) ->
    @file path

  files: (...paths) ->
    paths.flatten!.map (path) ->
      @file path

  fixtures: (...paths) ->
    paths.flatten!.map (path) ->
      @fixture path

  tests: (...paths) ->
    paths.flatten!.map (path) ->
      @test path