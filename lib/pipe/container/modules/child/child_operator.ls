Module    = require('jsclass/src/core').Module

ChildOperator = new Module(
  validate-child: (name, pipe) ->
    unless _.is-type 'String', name
      throw new Error "Name of pipe added must be a String, was: #{name}"

    unless _.is-type 'Object', pipe
      throw new Error "Pipe added as child must be an Object, was: #{pipe}"

    unless @has-children
      throw new Error "This pipe does not allow child pipes"
)

module.exports = ChildOperator