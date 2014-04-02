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

main-folders = <[pipe recource racer]>

Folders = (name) ->
  lo.each main-folders, ((folder) -> Folders.prototype[folder] = new PathMaker name, folder), @
  @

Folders.prototype.error = ->
  new PathMaker 'lib', 'errors'


api = {}

api-method = (name) ->
  api[name] = (...args) ->
    return new Folders name if lo.is-empty args
    require ['.', name, args].join '/'
  @

lo.each [\lib \test], api-method

shortcut = (name) ->
  api[name] = ->
    api.lib![name]

api.error = api.lib!.error

lo.each main-folders, shortcut, @

module.exports = api
