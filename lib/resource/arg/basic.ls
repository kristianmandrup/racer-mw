module.exports =
  id:
    result: 'guid'
  get
    result: 'value'
  del:
    result: 'deleted'
  set:
    required:
      * 'value'
    optional:
      * 'cb'
    result: 'previous' # previous value
  set-null:
    required:
      * 'value'
    optional:
      * 'cb'
    result: 'value' # previous value
  set-each:
    required:
      * 'object'
    optional:
      * 'cb'
  set-diff:
    required:
      * 'value'
    optional:
      * 'equal-fn'
      * 'cb'
  increment:
    optional:
      * 'by'
      * 'cb'
    result: 'number' # new number
  add:
    required:
      * 'object'
    optional:
      * 'cb'
    result: 'id' # new id