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

Api =
  lib: ->
    new Folders \lib
  test: ->
    new Folders \test

shortcut = (name) ->
  Api[name] = @lib![name]

lo.each main-folders, shortcut, @

module.exports = Api
