# RacerMw

Abstract underlying Racer model API with a more convenient API/DSL which takes care of much of the underlying complexity
of setting paths etc.

See [derby-model](http://derbyjs.com/#models) and [racer-example](https://github.com/Sebmaster/racer-example)
for inspiration and information on how to improve this project...

Please see [The Big Picture](https://github.com/kristianmandrup/racer-mw/wiki/The-big-picture) for a general idea of the design/architecture and goals of this project...

Also see the [middleware](https://github.com/kristianmandrup/middleware) project for a better understanding of the underlying "mechanics" of the pipeline.

The current APIs are slowly getting more stable...
Ideas/suggestions for improvement are more than welcome!

The main idea is that Pipes and Resources encapsulates the following key points:

- Create Pipes that encapsulate the underlying path in the store (model)
- Create Resources that wrap the Racer model API more elegantly ;)

 - CollectionResource, such as `users`, that can expect its instances to be of a certain "Class"
 - ModelResource, such as 'user', that is an instance of a "Class" and is contained by a CollectionResource
 - AttributeResource that can access the attribute of a ModelResource

 - middleware stack to be applied on Store (model) operations
  - on Create, Update (auth, validate, marshal)
  - Delete (auth)
  - on Get (auth, decorate)

For some more thoughts...

- [Mw design](https://github.com/kristianmandrup/racer-mw/lib/mw/Mw-Design.md)
- [Resource design](https://github.com/kristianmandrup/racer-mw/lib/resource/Resource-Design.md) (needs update)
- [Architecture overview](https://github.com/kristianmandrup/racer-mw//Architecture-Overview.md)

## TODO

Improve

 * Test suite
 * Documentation
 * DSL
 * Resource API as more "classical" model wrapper on loaded data

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
