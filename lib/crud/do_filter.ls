/*
Filters and sorts

See http://derbyjs.com/#filters_and_sorts

Filters create a live-updating list from items in an object or another list. They provide an interface similar to the array.filter and array.sort methods of Javascript, but the results automatically update as the input items change.

filter = model.filter ( inputPath, [name] )

inputPath: A path pointing to an object or array. The path’s values will be retrieved from the model via model.get(), and then each item will be checked against the filter function

name: (optional) The name of the function defined via model.fn(). May instead be a function itself. The function should have the arguments function(item, key, object) for collections and objects, and function(item, index, array) for arrays. Like functions for array.filter, the function should return true for values that match the filter

If model.filter is called without a filter function, it will create a list out of all items in the input object. This can be handy as a way to render all subscribed items in a collection, since only arrays can be used as an input to {#each} template tags.

filter = model.sort ( inputPath, [name] )

inputPath: A path pointing to an object or array. The path’s values will be retrieved from the model via model.get(), and then each item will be checked against the filter function

name: (optional) The name of the function defined via model.fn(). May instead be a function itself. The function should should be a compare function with the arguments function(a, b). It should return the same values as compare functions for array.sort

There are two default named functions defined for sorting, asc and desc. If sort is called without a function name, it defaults to using the asc function. These functions compare each item with Javascript’s less than and greater than operators. See MDN for more info on sorting non-ASCII characters.

You define functions to be used in model.filter and model.sort via model.fn. See the next section for more info.

A filter may have both a filter function and a sort function by chaining the two calls.
*/
Module      = require('jsclass/src/core').Module

requires    = require '../../requires'
lo          = require 'lodash'
_           = require 'prelude-ls'


# Array methods
# Array methods can only be used on paths set to arrays, null, or undefined.
# If the path is null or undefined, the path will first be set to an empty
# array before applying the method.
Filter = Module(
  # filter = model.filter ( inputPath, [name] )
  filter: (fn-name) ->
    @res = @perform 'filter', fn-name
    @

  # filter = model.sort ( inputPath, [name] )
  sort: (fn-name) ->
    @res = @perform 'sort', fn-name
    @

  scoped: (path) ->
    if @res
      @res.ref path

  get: ->
    if @res
      @res.get!
)