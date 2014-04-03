api = require './requires'

get = {
  file: (name) ->
    api.file name

  lib: (name) ->
    api.lib name

  test: (name) ->
    api.test name

  resource: ->
    api.resource!named

  pipe: (name) ->
    api.pipe!named name

  apipe: (name) ->
    api.pipe!apipe name

  pipe-builder: (name) ->
    api.pipe!builder!named name

  pipe-parser: (name) ->
    api.pipe!parser!named name

  pipe-value: (name) ->
    api.pipe!value!file name

  base: (name) ->
    api.pipe!base!file (name)

  base-extractor: (name) ->
    api.pipe!base!extractor!named name

  base-module: (name) ->
    api.pipe!base!modules!file name

  base-builder: (name) ->
    api.pipe!base!builder!file name

  attribute: (name) ->
    api.pipe!attribute!file name

  attribute-extractor: (name) ->
    api.pipe!attribute!extractor!named name

  attribute-builder: (name) ->
    api.pipe!attribute!extractor!named name

  model: (name) ->
    api.pipe!model!file name

  model-extractor: (name) ->
    api.pipe!model!extractor!named name

  model-builder: (name) ->
    api.pipe!model!builder!named name

  model-setter: (name) ->
    api.pipe!model!setter!named name

  collection: (name) ->
    api.pipe!collection!file name

  collection-attacher: (name) ->
    api.pipe!collection!attacher!named name

  collection-extractor: (name) ->
    api.pipe!collection!extractor!named name

  collection-builder: (name) ->
    api.pipe!collection!builder!named name

  collection-setter: (name) ->
    api.pipe!collection!setter!named name

  collection-value: (name) ->
    api.pipe!collection!value!named name

  path: (name) ->
    api.pipe!path!file name

  path-extractor: (name) ->
    api.pipe!path!extractor!named name

  value-object: (name) ->
    api.lib!value-object.named name

}

module.exports = get