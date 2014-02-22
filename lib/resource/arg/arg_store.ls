# concatenates all of the arg hashes into one store
ArgStore = new Class(
  initialize: ->
    @all = {}
    ['array', 'basic', 'query', 'reference', 'scoped', 'string'].each (command) ->
      lo.extend @all, requires.resource "arg/#{command}"
)

module.exports = ArgStore
