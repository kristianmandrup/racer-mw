# Promises Design

Would be nice to provide **Promises** as a more convenient way (wrapper) to work with live-updates, such as subscribe, fetch etc.
which use "old-school" event handlers. We should *promisify* these event handlers!

- [promises are better]https://blog.jcoglan.com/2013/03/30/callbacks-are-imperative-promises-are-functional-nodes-biggest-missed-opportunity/
- [promises](http://howtonode.org/promises)
- [deferred](https://www.npmjs.org/package/deferred) - *promisify* callback hell functions!

Both **Q** and **PromisedIO** provide utilities for wrapping or calling Node-style functions.

The *deferred* package is another alternative...

```javascript
var promisify = require('deferred').promisify;
var fs = require('fs');

// Convert node.js async functions, into ones that return a promise
var readdir = promisify(fs.readdir);
```

From [bogart](https://github.com/nrstott/bogart)

```javascript
function promisify(nodeAsyncFn, context) {
  return function() {
    var defer = q.defer()
      , args = Array.prototype.slice.call(arguments);

    args.push(function(err, val) {
      if (err !== null) {
        return defer.reject(err);
      }

      return defer.resolve(val);
    });

    nodeAsyncFn.apply(context || {}, args);

    return defer.promise;
  };
};
```

Perhaps the best (most featurecomplete) Promise library at this time is [bluebird](https://github.com/petkaantonov/bluebird)?
