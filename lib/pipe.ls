walk = (meth, steps) ->
        if steps > 10
          throw Error "You should NEVER have more than 10 pipes in a model pipeline!!!"
        step = 0
        location = @[meth]!
        while step < steps and locations isnt void
          location = location[meth]!
        location

Pipe = new Class(
      initialize: (@value-object)

      extend:
        $p = (hash) ->
          parent = @
          keys = _.keys(hash)
          throw Error "Must only have one key/value entry, was #{keys}"
          type = keys.first
          obj = hash[type]
          @$pipe.child = new PipeFactory(obj, parent: parent, type: type).create-pipe

        $pipe = (hash) ->
          keys = _.keys(hash)
          throw Error "Must only have one key/value entry, was #{keys}"
          type = keys.first
          new PipeFactory(hash[type], type: type).create-pipe

      $type   : @type
      $parent : @parent
      $child  : void
      $prev   : (steps) ->
        walk '$parent', steps
      $next    : (steps) ->
        walk '$child', steps
      $root: ->
        walk '$parent', 9
      $end: ->
        walk '$child', 9

      $calc-path: ->
        new PathResolver(@value-object).full-path!
)