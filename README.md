# RacerMw

Abstract underlying Racer model API with a more convenient API/DSL which takes care of much of the underlying complexity
of setting paths etc.

See [derby-model](http://derbyjs.com/#models) and [racer-example](https://github.com/Sebmaster/racer-example)
for inspiration and information on how to improve this project...

Please see [The Big Picture](https://github.com/kristianmandrup/racer-mw/wiki/The-big-picture) for a general idea of the design/architecture and goals of this project...

Also see the [middleware](https://github.com/kristianmandrup/middleware) project for a better understanding of the underlying "mechanics" of the pipeline.

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
