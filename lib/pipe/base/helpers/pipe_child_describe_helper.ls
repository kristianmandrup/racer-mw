Class = require('jsclass/src/core').Class
Proxy = require('jsclass/src/proxy').Proxy

lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeChildDecribeHelper = new Class(
  initialize: (@pipe) ->
    @config-proxies!
    @

  display: (children) ->
    if children then @describe-children true else @child-names!.length

  describe-children: (recursive) ->
    @no-children! or @describe-child-list!

  no-children: ->
    "no children" unless @has-children!

  describe-child-list: ->
    lo.map @child-names, @pipe.describe-child

  config-proxies: ->
    lo.each <[ child-type has-children child-names]>, @proxy, @

  # TODO: put in standard module
  proxy: (name) ->
    fun-name = name.camelize false
    @[fun-name] = @pipe[fun-name]
)

module.exports = PipeChildDecribeHelper