Class       = require('jsclass/src/core').Class
lo    = require 'lodash'
require 'sugar'

BuilderConfig = new Class(
  initialize: (@name, @valid-children = []) ->
    throw new Error "#{@name} is not a valid child" unless @valid-child name
    @config-parser!
    @

  config-builder:  ->
    lo.extend @builders, @builders-for(name)

  builders-for: (name) ->
    @create-config-builder(name).config!

  create-config-builder: (name) ->
    new ConfigBuilder @, name

  config-parser: ->
    lo.each @fun-names, @add-parse-fun

  fun-names: ->
    [@name, @aliased-name!].compact!

  add-parse-fun: (name) ->
    @[@fun-name name] = @parser-fun if name

  aliased-name: ->
    @alias[name]

  fun-name: (name) ->
    "parse#{name.camelize false}"

  parser-fun: (...args) ->
    @[name]!.parse ...args

  alias:
    attributes: 'attrs'
    collections: 'cols'
    models: 'modls'

  valid-child: (name) ->
    name in @valid-children
)

module.exports = BuilderConfig