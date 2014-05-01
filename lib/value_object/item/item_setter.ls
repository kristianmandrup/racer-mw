Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!

ItemMutator = requires.value-object!item.named 'mutator'

ItemSetter = new Class(ItemMutator,
  # compare, only overwrite if different value
  set: (@index) ->
    return if @new-item! is old.item.raw-value!

    if @parser
      console.log 'item', item.describe!
      @container.child-hash[i] = item
)

module.exports = ItemSetter
