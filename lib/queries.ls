Queries = new Class(
  initialize: (@value-object)

  oldest: (num) ->
    {$sort: {asc: 'create-date'} }.extend @limit(num)

  latest: (num) ->
    { $sort: {desc: 'create-date'} }.extend @limit(num)

  limit: (num) ->
    { $limit: num }
)

module.exports = Queries