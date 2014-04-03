# only applies for Collection and Model
module.exports =
  commands:
    create:
      * 'query'   # new Query   @resource, @query
      * 'filter'  # new Filter  @resource, @filter
      * 'sort:filter'
