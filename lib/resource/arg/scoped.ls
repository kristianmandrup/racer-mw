module.exports =
  # wherever a path is accepted in a racer method, a scoped model can typically be used as well.
  'at':
    optional:
      * 'path'
    result: 'scoped'
  'scope':
    optional:
      * 'path'
    result: 'scoped'
  'parent':
    optional:
      * 'parent'
    result: 'scoped'
  'path':
    optional:
      * 'subpath'
    result: 'scoped'
