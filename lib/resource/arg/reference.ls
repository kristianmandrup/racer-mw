module.exports =
  ref:
    optional:
      * 'options'
    required
      * 'to'
    result: 'scoped'
  ref-list:
    optional:
      * 'options'
      * 'cb'
    required:
      * 'collection'
      * 'ids'
    result: 'scoped'
  remove-ref: void
  remove-ref-list: void
  remove-all-refs: void
  dereference:
    result: 'resolved'
