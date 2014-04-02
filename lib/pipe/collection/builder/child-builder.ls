Class = require('jsclass/src/core').Class

CollectionChildBuilder = new Class(
  initialize: (@pipe)
    @

  # Array
  build-children: (@value) ->
    throw new Error 'build-children - NOT yet implemented'
    # for each item compare with current value
    # if different, create new ModelPipe and overwrite
    # else skip

    # if more items than original array, create and insert new children by parsing
    # if less items than original, either: remove remaining children or return? take extra options param?
    # to contract value if this array smaller than current

    # set-value [x, y, z], contract: true
    # to only overwrite 3 first but ignore the rest
    # set-value [x, y, z]

    # insert lists at specific positions
    # set-value-at 3: [x, y, z], 6: [a, b]


  builder-for: ->
    @builder(@builder-name!)

  builder-name: ->
    if @is 'array' then 'models' else 'model'

  is: (type) ->
    typeof! @value is type.capitalize!
)