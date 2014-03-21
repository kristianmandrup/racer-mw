module.exports =
  push:
    required:
      * 'value'
    optional:
      * 'cb'
    result: 'length'
  unshift:
    required:
      * 'value'
    optional:
      * 'cb'
    result: 'length'
  insert:
    required:
      * 'index'
      * 'values'
    optional:
      * 'cb'
    result: 'length'
  pop:
    optional:
      * 'cb'
  shift:
    optional:
      * 'cb'
    result: 'item'
  move:
    optional:
      * 'how-many'
      * 'cb'
    required:
      * 'from'
      * 'to'
    result: 'moved'
  remove:
    optional:
      * 'how-many'
      * 'cb'
    required: 'index'
    result: 'removed'
