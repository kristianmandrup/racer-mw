# RacerMw

Abstract underlying Racer model API with a more convenient API/DSL which takes care of much of the underlying complexity
of setting paths etc.

See [derby-model](http://derbyjs.com/#models) and [racer-example](https://github.com/Sebmaster/racer-example)
for inspiration and information on how to improve this project...

Please see [The Big Picture](https://github.com/kristianmandrup/racer-mw/wiki/The-big-picture) for a general idea of the design/architecture and goals of this project...

Also see the [middleware](https://github.com/kristianmandrup/middleware) project for a better understanding of the underlying "mechanics" of the pipeline.

## Crud

The Crud should enable something like this

```LiveScript
Crud = require 'crud'

crud = (collection) ->
  new Crud collection

crud('users').get(id).one
crud('users').get!.one id

users = crud 'users'
user = users.get!.one(id)
users.get!.by(name: name).first

user.set name: 'another name', age: 42

admin-users = users.query.find admin: true

guest-users-ref = users.query.get-live-update role: 'guest'
user.delete
```

This *Crud API* should further be wrapped in a `Resource` API for real data-aware models, similar to Angular *$resource* perhaps.

## TODO

Improve

 * Test suite
 * Documentation
 * DSL

Support

 * all Racers [model](https://github.com/kristianmandrup/racer-mw/wiki/Racer-model-explained) methods
 * [subscriptions](https://github.com/kristianmandrup/racer-mw/wiki/Racer-model-subscriptions) to model change events ;)

## Contributing

Please :) Any help is greatly appreciated!

## Testing

Just use *mocha*

`$ mocha`

Run particular test

`$ mocha test/racer-mw/crud_test.js`

Easy :)


## License

MIT
Copyright 2014 Kristian Mandrup
