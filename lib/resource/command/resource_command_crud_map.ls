# use regex matching to match ;)
module.exports =
  read:
    * 'get'
    * 'at'
    * 'scope'
    * 'parent'
    * 'path'
    * 'leaf'
    * 'ref'
    * 'ref-list'
    * 'query'
    * 'filter'
    * 'sort'
  update:
    * 'set'
    * 'inc'
    * 'string-insert'
    * 'add'
    * 'push'
    * 'shift'
    * 'move'
  delete:
    * 'del'
    * 'unshift'
    * 'pop'
    * 'remove'
    * 'shift'
    * 'move'
  special:
    * 'remove-ref'
    * 'remove-ref-list'
