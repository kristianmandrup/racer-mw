Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!

ChildOperator = get.pipe-container 'child/child_operator'

PipeChildRemover = new Module(
  include:
    * ChildOperator
    ...

  remove-child: (name) ->
    removed = lo.extend {}, @child-hash[name]
    removed.parent = void
    delete @child-hash[name]
    @update-child-count!
    removed
)

module.exports = PipeChildRemover