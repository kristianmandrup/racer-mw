Class     = require('jsclass/src/core').Class
requires  = require '../../../requires'

_  = require 'prelude-ls'
require 'sugar'

CommandBuilder = new Class(
  initialize: (@commander, @prefix) ->
    @commands = @commander.commands
    @

  build: ->
    self = @
    _.keys(@commands).each (name) ->
      type = self.parse-type name
      switch type
      case 'on'
        self.on-command name, self.commands[name]
      case 'set'
        self.set-command name, self.commands[name]
      case 'create'
        self.create-command self.commands[name]
      default
        self.command self.commands[name]
    @commander

  parse-type: (name) ->
    return 'on' if name.match /^on/
    return 'set' if name.match /^on/
    return 'create' if name.match /^create/

  function-name: (name) ->
    if @prefix
      unless name.match /#{prefix}/
        return "#{prefix}#{name}"
    name

  command: (functions) ->
    functions = [functions].flatten!
    self = @
    functions.each (fun) ->
      fun-name = fun.camelize(false)
      self.commander[@function-name fun-name] = (args) ->
        @perform fun-name, args
        @

  # creates and sets a Filter or Query
  create-command: (functions) ->
    functions = [functions].flatten!
    self = @
    functions.each (fun) ->
      fun-name = fun.camelize(false)
      clazz = fun-name
      if fun-name.match /:/
        parts     = fun-name.split(':')
        fun-name  = parts.first!
        clazz     = parts.last!

      self.commander[@function-name fun-name] = (args) ->
        @[fun-name] = new requires.resource(clazz)(self.commander, args)
        @

  set-command: (name, functions) ->
    set-var = name
    functions = [functions].flatten!
    self = @
    functions.each (fun) ->
      fun-name = fun.camelize false
      self.commander[@function-name fun-name] = (args) ->
        @[set-var] = @promise fun-name, args
        @

  on-command: (name, functions) ->
    on-var = @on-var name
    self = @
    functions = [functions].flatten!
    functions.each (fun) ->
      fun-name = fun.camelize false
      self.commander[@function-name fun-name] = (args) ->
        return on-var[fun-name]! if on-var?
        @perform fun-name, args
        @

  on-var: (name) ->
    name.replace /^on/, ''

)

module.exports = CommandBuilder