module.exports =
  push:
    required:
      * 'value'
    optional:
      * 'path'
      * 'cb'
    result: 'length'
  unshift:
    required:
      * 'value'
    optional:
      * 'path'
      * 'cb'
    result: 'length'
  insert:
    required:
      * 'index'
      * 'values'
    optional:
      * 'path'
      * 'cb'
    result: 'length'
  pop:
    optional:
      * 'path'
      * 'cb'
  shift:
    optional:
      * 'path'
      * 'cb'
    result: 'item'
  move:
    optional:
      * 'path'
      * 'howMany'
      * 'cb'
    required:
      * 'from'
      * 'to'
    result: 'moved'
  remove:
    optional:
      * 'path'
      * 'how-many'
      * 'cb'
    required: 'index'
    result: 'removed'
