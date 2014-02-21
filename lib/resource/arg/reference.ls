module.exports =
  ref:
    optional:
      * 'path'
      * 'options'
    required
      * 'to'
    result: 'scoped'
  ref-list:
    optional:
      * 'path'
      * 'options'
      * 'cb'
    required:
      * 'collection'
      * 'ids'
    result: 'scoped'
  remove-ref:
    optional:
      * 'path'
  remove-ref-list:
    optional:
      * 'path'
  remove-all-refs
    optional:
      * 'path'
  dereference:
    optional:
      * 'path'
    result: 'resolved'
