Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!

ChildOperator = get.pipe-container 'child/child_operator'

PipeChildAdder = new Module(
  include:
    * ChildOperator
    ...

  add-child: (name, pipe) ->
    @validate-child name pipe
    pipe.parent = @
    @child-hash[name] = pipe
    @update-child-count!
)

module.exports = PipeChildAdder