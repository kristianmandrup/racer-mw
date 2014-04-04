Module      = require('jsclass/src/core').Module
get         = require '../../../../requires' .get!

ChildStats    = get.pipe-container.child 'stats'
ChildAdder    = get.pipe-container.child 'adder'
ChildRemover  = get.pipe-container.child 'remover'

# Methods to access/operate on child pipes
PipeContainer = new Module(
  include:
    * ChildStats
    * ChildAdder
    * ChildRemover
    ...

  allow-children: true

  child: (name) ->
    unless @child-hash[name] then
      throw new Error "Pipe has no named: #{name}"
    @child-hash[name]

  update-child-count: ->
    @child-count = @child-names!.length

  post-init: ->
    @clear-children!

  clear-children: ->
    @child-hash = {}
    @update-child-count!
    @
)

module.exports = PipeContainer