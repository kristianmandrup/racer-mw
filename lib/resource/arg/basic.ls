module.exports =
  id:
    result: 'guid'
  get
    optional:
      * 'path'
    result: 'value'
  del:
    optional:
      * 'path'
    result: 'deleted'
  set:
    required:
      * 'value'
    optional:
      * 'path'
      * 'cb'
    result: 'previous' # previous value
  set-null:
    required:
      * 'value'
    optional:
      * 'path'
      * 'cb'
    result: 'value' # previous value
  set-each:
    required:
      * 'object'
    optional:
      * 'path'
      * 'cb'
  set-diff:
    required:
      * 'value'
    optional:
      * 'equal-fn'
      * 'path'
      * 'cb'
  increment:
    optional:
      * 'by'
      * 'path'
      * 'cb'
    result: 'number' # new number
  add:
    required:
      * 'object'
    optional:
      * 'path'
      * 'cb'
    result: 'id' # new id