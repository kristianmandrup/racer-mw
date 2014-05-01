Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!

ItemMutator = requires.value-object!item.named 'mutator'

ItemPusher = new Class(ItemMutator,
  # compare, only overwrite if different value
  push: (@index) ->
    console.log 'push-item'
    if @parser
      @container.attach @item!
)

module.exports = ItemPusher
