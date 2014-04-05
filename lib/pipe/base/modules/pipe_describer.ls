Module = require('jsclass/src/core').Module
util   = require 'util'

PipeDescriber = new Module(
  describe: (children) ->
    type: @pipe.info?.type
    name: @name
    id: @id! if @id
    value: @value!
)

module.exports = PipeDescriber