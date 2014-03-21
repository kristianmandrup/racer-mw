lo = require 'lodash'
require 'sugar'

ResourceQueries = new Class(
  initialize: (@value-object)

  # just a few typical examples - feel free to add more!
  oldest: (num) ->
    lo.extend @asc 'create-date', @limit(num)

  latest: (num) ->
    lo.extend @desc 'create-date', @limit(num)

  asc_date: (field = 'create-date') ->
    {$sort: {asc: field} }

  desc-date: (field = 'create-date') ->
    { $sort: {desc: field} }

  limit: (num) ->
    { $limit: num }
)

module.exports = ResourceQueries