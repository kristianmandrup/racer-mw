/**
 * User: kmandrup
 * Date: 17/02/14
 * Time: 23:20
 */

DoAttribute = Class(
  # num = model.increment ( path, [byNum], [callback] )
  # Number only (simple value)
  # authorize on container, Update
  # validate on container
  increment: (by-num, cb) ->
    @perform 'increment', byNum, cb

  # obj = model.setNull ( path, value, [callback] )
  # set only if null
  # can be Document or simple value
  # authorize on container and value if Document, Update
  if-null: (value) ->
    @perform 'setNull', value
)