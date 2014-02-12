Crud = require 'crud'

crud = (collection) ->
  new Crud collection

crud('users').get(id).one
crud('users').get!.one(id)

users = crud('users')
users.get!.one(id)
users.get!.by(name: name).first
users.get!.by(name: name).all