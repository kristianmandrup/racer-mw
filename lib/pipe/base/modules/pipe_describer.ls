Module = require('jsclass/src/core').Module
util   = require 'util'

PipeDescriber = new Module(
  describe: (children) ->
    type: @pipe.type
    name: @name
    id: @id! if @id
    value: util.inspect @value!
)

module.exports = PipeDescriber