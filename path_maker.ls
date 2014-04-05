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


  resolve: (paths) ->
    req-path = @full-path paths
    return req-path unless @auto-resolve
    require req-path

  full-path: (xpaths) ->
    ['.', @flat-paths!, xpaths].compact!.flatten!.join '/'

  flat-paths: ->
    @paths.compact!.flatten!

  last-single-path: ->
    last = @paths.flatten!last!
    last.singularize!

  file: (name) ->
    @paths.push name
    @resolve!

  named: (name, ...args) ->
    unless name is void
      @paths.push [name, @last-single-path!].join '_'
    @resolve args
)

protos =
  configure: ->
    lo.each @folders, @create-fun, @

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

  folders:
    * \pipe
    * \attribute
    * \base
    * \builder
    * \builders
    * \child
    * \container
    * \collection
    * \dsl
    * \extractor
    * \family
    * \helpers
    * \model
    * \modules
    * \named
    * \parser
    * \path
    * \setter
    * \tuple
    * \typer
    * \validator
    * \value

PathMaker.prototype <<< protos
PathMaker.prototype.configure!

module.exports = PathMaker