# RacerMw

[![Greenkeeper badge](https://badges.greenkeeper.io/kristianmandrup/racer-mw.svg)](https://greenkeeper.io/)

Abstract underlying Racer model API with a more convenient API/DSL which takes care of much of the underlying complexity
of setting paths etc.

The main idea is that *Pipes* and *Resources* encapsulate the following key entities:

**Pipe**

 - encapsulate the underlying path in the store (model)
 - is connected to a resource

**Resource**

- wraps the Racer model API
- encapsulates the value of a node in the model
- uses its pipe to know its current path in the model

## Pipes

Each pipe is connected to a resource.

See [Pipe Design](https://github.com/kristianmandrup/racer-mw/blob/master/lib/pipe/Pipe-Design.md)

## Resources

A resource will get the model path for where to sync its value from its pipe.

* CollectionResource, such as `users`, that can expect the instances it contains to all be of a certain "Class"
* ModelResource, such as 'user', that is an instance of a "Class" and is contained by a CollectionResource
* AttributeResource that can access the attribute of a ModelResource

See [Resource Design](https://github.com/kristianmandrup/racer-mw/blob/master/lib/resource/Resource-Design.md)

## Middleware stack

Any model store operation is categorized as either a Read, Update or Delete (RUD) command.
Depending on the type of command, a different Middleware stack is applied (injected) as part of the operation.

* Read - authorize, decorate
* Update - authorize, validate, (container validate?), marshal
* Delete - authorize, (container validate?)

See [Mw design](https://github.com/kristianmandrup/racer-mw/lib/mw/Mw-Design.md)

Better overview:

* [Architecture overview](https://github.com/kristianmandrup/racer-mw//Architecture-Overview.md)
* [Files overview](https://github.com/kristianmandrup/racer-mw/blob/master/lib/Files%20overview.md)
* [Racer Sync Design](https://github.com/kristianmandrup/racer-mw/tree/master/lib/racer/Sync-Design.md)
* [Promises Design](https://github.com/kristianmandrup/racer-mw/blob/master/Promises-Design.md)

[Wiki](https://github.com/kristianmandrup/racer-mw/wiki)

* [The Big Picture](https://github.com/kristianmandrup/racer-mw/wiki/The-big-picture)

Other links:

* [derby-model](http://derbyjs.com/#models)
* [racer-example](https://github.com/Sebmaster/racer-example)
* [middleware](https://github.com/kristianmandrup/middleware) - engine for Middleware

## TODO

Design architecture for leveraging subscriptions and live updates (promises?) (bacon.js?)

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
