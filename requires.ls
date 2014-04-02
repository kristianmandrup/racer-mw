PathMaker = require './path_maker'

PathMaker.prototype.folders =
  * \pipe
  * \attribute
  * \base
  * \builder
  * \builders
  * \collection
  * \dsl
  * \extractor
  * \family
  * \model
  * \modules
  * \parser
  * \path
  * \setter
  * \tuple
  * \typer
  * \validator
  * \value

lo = require 'lodash'

main-folders = <[pipe recource racer value-object]>

Folders = (name) ->
  path-name = name.underscore!

  create-folder-fun = (folder) ->
    fun-name = folder.camelize false
    Folders.prototype[fun-name] = new PathMaker path-name, fun-name.underscore!

  lo.each main-folders, create-folder-fun
  @

Folders.prototype.error = ->
  new PathMaker 'lib', 'errors'

api = {}

api-method = (name) ->
  fun-name = name.camelize false
  path-name = name.underscore!
  api[fun-name] = (...args) ->
    return new Folders path-name if lo.is-empty args
    require ['.', path-name, args].join '/'
  @

lo.each [\lib \test], api-method

shortcut = (name) ->
  fun-name = name.camelize false
  api[fun-name] = ->
    api.lib![fun-name]

api.error = api.lib!.error

lo.each main-folders, shortcut, @

module.exports = api
