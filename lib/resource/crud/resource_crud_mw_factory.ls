Class     = require('jsclass/src/core').Class
requires  = require '../../../requires'

_  = require 'prelude-ls'
require 'sugar'

middleware = require 'middleware'
Middleware = middleware.Middleware

CrudMwFactory = new Class(
  # Create, Read, Update, Delete
  initialize: (crud-operation) ->
    unless typeof crud-operation is 'string'
      throw new Error "Crud operations must be a String, was: #{typeof crud-operation}"

    @crud-operation = crud-operation.lowercase!

  validate-crud-op: ->
    unless @valid-crud-ops!.include @crud-operation
      throw new Error "Invalid Crud operation #{@crud-operation}. Must be one of: #{@valid-crud-ops!}"

  valid-crud-ops: ->
    _.keys @crud-stacks

  # return appropriate middleware stack(s)
  build: ->
    @create-crud-stacks!

  create-crud-stacks: ->
    ios = @crud-stacks[@crud-operation]
    stacks = {}
    _.keys(ios).each (io) ->
      stacks[io] := @build-stack(io, ios[io])

  # io: input or output
  build-stack: (io, mws) ->
    @stack-for(mws).each (mw) ->
      @middleware!.use mw

  middleware: ->
    @mware ||= new Middleware('model')

  stack-for: (mws) ->
    self = @
    mws.map (mw) ->
      {mw: @["#{mw}-mw"]}


  # https://github.com/kristianmandrup/authorize-mw
  # https://github.com/kristianmandrup/authorize-mw/blob/master/index.ls
  # TODO: missing js files :O - fix .gitignore!
  authorize-mw:   require('authorize-mw').authorize-mw

  # https://github.com/kristianmandrup/validator-mw
  # https://github.com/kristianmandrup/validator-mw/blob/master/index.js
  validate-mw:    require('validator-mw').validation-mw

  # https://github.com/kristianmandrup/decorator-mw
  # https://github.com/kristianmandrup/decorator-mw/blob/master/index.js
  decorator-mw:   require('decorator-mw').DecoratorMw

  # https://github.com/kristianmandrup/marshaller-mw
  # https://github.com/kristianmandrup/marshaller-mw/blob/master/index.js
  marshaller-mw:  require('marshaller-mw').MarshallerMw

  # each CRUD operation is either an I or an IO-operation
  crud-stacks:
    create:
      input:
        * 'authorize'
        * 'validate'
        * 'marshaller'
    read:
      input:
        * 'authorize'
      output:
        * 'decorate'
    update:
      input:
        * 'authorize'
        * 'validate'
        * 'marshaller'
    delete:
      input:
        * 'authorize'
)

