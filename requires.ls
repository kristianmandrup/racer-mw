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

main-folders = <[pipe resource racer value-object]>

Folders = (name) ->
  path-name = name.underscore!

  create-folder-fun = (folder) ->
    fun-name = folder.camelize false
    Folders.prototype[fun-name] = new PathMaker path-name, fun-name.underscore!

  lo.each main-folders, create-folder-fun
  @

Folders.prototype.error = ->
  new PathMaker 'lib', 'errors'

api = {
  d:
    resource: ->
      api.resource!.named

    pipe: ->
      api.pipe!named

    base: ->
      api.pipe!base!file

    base-extractor: ->
      api.pipe!base!extractor!named

    base-module: ->
      api.pipe!base!modules!file

    base-builder: ->
      api.pipe!base!builder!file

    attribute: ->
      api.pipe!attribute!file

    attribute-extractor: ->
      api.pipe!attribute!extractor!named

    attribute-builder: ->
      api.pipe!attribute!extractor!named

    model: ->
      api.pipe!model!file

    model-extractor: ->
      api.pipe!model!extractor!named

    model-builder: ->
      api.pipe!model!builder!named

    model-setter: ->
      api.pipe!model!setter!named

    collection: ->
      api.pipe!collection!file

    collection-attacher: ->
      api.pipe!collection!attacher!named

    collection-extractor: ->
      api.pipe!collection!extractor!named

    collection-builder: ->
      api.pipe!collection!builder!named

    collection-setter: ->
      api.pipe!collection!setter!named

    collection-value: ->
      api.pipe!collection!value!named

    path: ->
      api.pipe!path!file

    path-extractor: ->
      api.pipe!path!extractor!named
}

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
