Class       = require('jsclass/src/core').Class

require 'sugar'
lo = require 'lodash'

PathMaker = new Class(
  initialize: (...args) ->
    @paths = []
    @paths.push args
    @configure!
    @auto-resolve = true
    @

  enable: (name) ->
    @set name

  disable: (name) ->
    @set name, false

  set: (name, value = true) ->
    prop-name = name.camelize false
    @[prop-name] = value unless @[prop-name] is void or typeof! prop-name is 'Function'
    @

  configure: ->
    lo.each @folders, @create-fun, @

  resolve: (paths) ->
    req-path = @full-path paths
    return req-path unless @auto-resolve
    require req-path

  full-path: (xpaths) ->
    ['.', @paths, xpaths].compact!.flatten!.join '/'

  create-fun: (fun-name) ->
    @[fun-name] = (name, ...args) ->
      @paths.push fun-name
      @paths.push "#{name}_#{fun-name}" unless name is void
      @paths.push args unless lo.is-empty args
      @

    @["a#{fun-name}"] = (name, ...args) ->
      unless name is void
        @paths.push name
        @paths.push "#{name}_#{fun-name}"
      @paths.push args unless lo.is-empty args
      @resolve!

  named: (name, ...args) ->
    @paths.push name unless name is void
    @resolve args
)

module.exports = PathMaker