/**
 * User: kmandrup
 * Date: 17/02/14
 * Time: 23:20
 */

DoAttribute = Class(
  # num = model.increment ( path, [byNum], [callback] )
  # users.set!.path('age').add admin-user, (res) ->
  increment: (by-num, cb) ->
    @perform 'increment', byNum, cb

  # obj = model.setNull ( path, value, [callback] )
  # set only if null
  if-null: (value) ->
    @perform 'setNull', value

  # previous = model.set ( path, value, [callback] )
  value: ->
   @perform 'set', value
)