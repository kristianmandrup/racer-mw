modules.exports =
  query:
    required:
      * 'collection'
    result: 'query'
  db-query:
    required:
      * 'collection'
    optional:
      * 'q'
    result: 'query'
