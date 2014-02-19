# Design

## Read Doc

Query or Get documents, including using Filter. Apply only Authorization.

## Set Doc

Any operation which inserts or overwrites Documents into the model. The data must first be marshalled.

## Reposition Doc

Similar to Set, but since no new data is coming in, no need for marshalling step

## Create Doc

Any operation which specifically creates new data?

## Delete Doc

Any operation which deletes one or more Documents

## Read Attrib

Must indicate model (Doc) being read from, then authorize on that! Same for other Attrib ops

## Set Attrib

Any operation which inserts or overwrites non-Doc Attributes in the model.
The data must first be marshalled. How?

`marshaller-for('password').marshal password)`

## Set Array (non-docs)

Set Attrib should be called for each element in array? Not efficient
Better to marshal all first, then call single SetEach operation
Pipeline needs more thought for optimization of List data in general

## Lessons learned

Operations fall into the following categories

**Operates on a Document within a collection**

```
users.1.user
users.2.user
```

**Operates on a Document within a collection of another document**

```
users.1.user.admins.1.admin-user
```

Should we validate as to whether this admin-user is valid for the user who owns the collection?

```
users.1.user.admins.1.admin-user.tags = ['abra', 'ca', 'dabra']
```

What if we move or pop an element from the tags collection (simple String values).
Should we validate with respect to the `admin-user`


**Operates on a simple attribute**

```
model.stringInsert 'users.1.user.text-area', 'hello'
```

Should authorize and validate on container Document `user`...

## More advanced pipelining

From the above analysis we can see the following conclusions taking shape...

We might need two middleware pipelines.

- container-stack
- item-stack

For some operations, it is the container model object that determines whether the operation is allowed
For others it is the item itself, being inserted into some named collection (not a model object).

The container-stack will always be simple, since it will never have to bother about marshalling or decoration.
It will thus only concern authorization and validation of the operation.
Most often it will likely be a "by-pass" operation... ;)

Example

Add new Document (model obj) to an attribute (List) of container Document (model obj).

### Adv. Validation

The validation could take the container object, the attribute and the item obj and validate whether
the container obj allows this item obj to be inserted into the list.
This could be based either on the type of container and item object or even on the state of the container object (which
could be set up to live-update subscribe to changes in the model).

`mw-stack('container').validate container: container, attribute: attribute, item: item`

Of course this could later be optimized to a nicer DSL if need be

`mw-stack('container').validate-on(container).add-to(attribute, item)`

Note: See below, this can be vastly simplified by employing a hierachical model to reflect this
and then have each level "do its thing". Then each layer will have at most one mw-stack!

### Adv. Authorization

`mw-stack('container').authorize.can 'add', data: item, ctx: {container: container, attribute: attribute}`

The key is to allow the developer to configure this as required while facilitating certain common patterns.
We should not apply too strict conventions, at least until we have uncovered typical repetitive usage patterns
that can be encapsulated.

## Resources

As we can now start to see...

```
users-col = collection('users')
user  = users.get-by name: name

page = container('_page')
current-user = page.attribute('current').model('user').get-by email: user.email
current-user.$save!
current-user.$set name: 'unknown'

# should try to add to 'projects'
current-user.$add(project)

current-user.$set current-project: project
current-user.$get 'project', {status: 'done'}

current-user.$add('my-projects', project)
current-user.$delete!

admin-user = {
  name: 'Kris'
  role: 'admin'
  clazz: 'user'
}


To chain, simply use `$a` stands for a <something> or simply short for "add" ;)
This should build you the whole path model with all the cool logic buried inside...

page.$a(attribute: 'current').$a(model: admin-user).$set role: 'guest'

# get all admin users since past 3 days
page.$a(collection: admin-user).$query date: {$gte: days(3).before(new Date) }}
```

The Resource should contain the following

admin-user = {
  name: 'Kris'
  role: 'admin'

  $clazz: 'user'

  $save: ->
  $set: (value-hash) ->
  $get: (model, query)
  $delete: ->
  $parent: parent
}
```

```
users-col.$a(path: 'current.admin').$a(model: admin-user)

# collection (same as path)
users-col = {
  $type: 'collection'
  $path: 'users'
  $calc-path: ->
    @collection
}

# path
current-admin-path = {
  $type: 'path'
  $path: 'current.admin'
  $parent: users-col

  # for chaining - should be included/inherited
  $a: (hash) ->

  # Note: we should only generate this method only when we need it, in one of the Resource methods such as $save!
  $calc-path: ->
    new PathResolver(@).full-path

}

# model-obj (Resource)
admin-user = {
  $type:  'resource'
  $class: 'user'
  $parent: current-admin-path
}
```

Note that a model-obj (Resource) can also act as a "collection" or "user"

In the following we use `admin-user` both as an "end" pipe and a container "pipe" (better term than pipe?).
We should not share the reference, so the call to `$a`must be a constructor, and `admin-user` must be cloned by value
 or just the relevant values extracted when used as a container.

So the call to `.$a(model: project)` on the model obj for `admin-user` must turn it into a container, without affecting
the `$pipes.admin.user`. In turn, as a container, the mw-stack should be changed, so as to not marshal or decorate.
the Validator step should also be different, such that it sends something like: `container: @, data: @.$child`


```
$pipes.admin.user     = users-col.$a(model: admin-user)
$pipes.admin.project  = users-col.$a(model: admin-user).$a(model: project)
```

So we can see we need a `$child` for the `admin-user-container` that points to the next item in the pipe.
To avoid too pipe-specific properties/methods in the core data/behavior namespace, we should create
 a namespace `$pipe` to contain them.
```
admin-user-container = {
  $class: 'user'
  $pipe:
    $type:  'container'
    $parent: current-admin-path
    $child: project
}

```
# ags: Hash - key = type, value = object
# creates a new pipe of the given type from the value
$a = (hash) ->
  self = @
  keys = _.keys(hash)
  throw Error "Must only have one key/value entry, was #{keys}"
  keys.each (type)
    @$pipe.child = new PipeFactory(self, type, hash[type]).create-pipe
  @$pipe.child
```

And now the pipe factory :)

```
PipeFactory = Class(
  initialize: (@parent, @type, @object) ->

  create-pipe: ->
    @object.$pipe = pipe!

  set-mw: ->
    switch @type
    case 'model'
    default
      @object.$resource.mw-stack.remove types: ['validator', 'authorizer']

  pipe: ->
    {
      $type   : @type
      $parent : @parent
      $child  : void
    }
)
```

Sure looks pretty sweet and workable!

``
project = {
  $class: 'project'
  $pipe
    $type:  'resource'
    $parent: admin-user
    $child  : void
}
```

Come to think of it, does it even make sense with this syntax:

`users-col.$a(model: admin-user).$a(model: project)`

The top levels are always some sort of containers. They only have different behavior depending on whether
they are a full resource-pipe or just a simple-pipe. Their position in the pipeline determines their relative behavior
with respect to the pipeline. So really no need for the `type` part I think.
Simplify to: (using `$p` for pipe)

`$pipe('users').$p(admin-user).$p('deeper.path').$p(project)`

Much better! We could allow the type variant just for decorative/debugging purposes.

### Validation

This fact is important for validation purposes. When we validate, we should validate the action with respect
to all the parents. They also have are allowed say whether the data is valid in that context.
However mostly the parents don't care and leave the child to do its own thing as long as it
stays within its own boundaries...

### Authorization

For authorization we should also send in the list of parents as part of the context in which to authorize in.
The permit (or any othr authorization logic) is then free to use this information to decide.

We need a PathResolver to resolve the full path at each step in the hierarchy.
This way we extract this functionality (Single Responsibility) and avoid cluttering each Resource with source logic...

Note that in both cases, if the parent is a model-object, it could beset up to *live-update*.
Hence when doing validation/authorization we can be sure it is with respect to its latest state and not some old state
no longer "in touch" with the server. Perhaps we should enforce this somehow (or at least make it default)

## Enable/Disable validation and authorization

In some (most?) cases, there is no need to consult the parent(s) for Auth and Val. It should thus be easy
to disable Auth and Val for any "piece in the puzzle".

```
# turn off validation
users-col.$mw.off 'v'
users-col.$mw.off! # turn all mw off
users-col.$mw.on! # turn all mw on

users-col.$a(model: admin-user).$mw.off!.$a(...)
```

## Marshalling

We have added a few `$` prefixed properties and methods to the Resouce model.
You don't want these values to be stored in the DB. So the marshalling should ensure that any $ value
is always discarded and then they will be put back on by the Resource decorator :)

### Path resolution

```
PathResolver = Class(
  initialize: (@model-obj) ->
    @collection = @pluralize model-obj.clazz
    @parent = model-obj.$parent

  obj-path: ->
    @collection

  parent-path: ->
    if @parent? then @parent.calc-path else void

  full-path: ->
    [@parent-path, @obj-path].compact!.join '.'
)
```

Now that we can calculate the paths at any step, we need to implement the main Resource methods

### $set current model object as-is

```
# set with current values
$save: ->
  $set @
```

### $set model object

```
# perform should be responsible for generating the path to be used
# should first authorize, validate and marshal
# it should generate $calc-path which runs in the context of @ being the Resource obj
$set: (value-hash) ->
  @perform 'set', value-hash
```

### $set attribute with value

```
$set: (attribute, value) ->
  vhash = {}
  vhash[attribute] = value
  $set vhash
```

```
# same as $set but using 'if-null' method, setting only if null (not present yet!)
$set-null: (attribute, value, opts) ->
```

### $get model

```
# should first authorize
$get: (model)
  @perform 'get', @get-for(model)
```

### $get query

```
# query under current path
# should first authorize
$get: (q: query)
  @perform 'get', @get-for(model)
``

```
# should first authorize
$delete: ->
  @perform 'del'
```

## Extras

### $inc attribute

```
# should first authorize
$inc: (attribute) ->
  @perform 'increment', attribute
```

### $push model-obj

If parent is a collection

```
$push: ->
  @perform 'push', value
```

As we see here, path or perform should create a new Execution object,
decoupled from the Resource itself, only referencing it

Path coupled with the current path should add up to path that points to collection
If no value as 2nd arg, then use self (model obj)

```
$push: (path) ->
  @path(path).perform 'push', value
```

If no value as 2nd arg, then push this

```
$push: (path, value) ->
  @path(path).perform 'push', value
```

values can be a list of args or an array

```
$push: (path, values) ->
  @path(path).perform 'push', values.flatten!.compact!
```

To avoid cluttering the model with all these Resource methods, we should have them in one place

```
user = {
  $clazz: 'user'
  $res: ->
    @$resource ||= new Resource @
}

user.$res!.save!
user-res = user.$res!
user-res.save!
user-res.del!
```

or even

`res = $resource(user).$save!.has(email: email)`

Where `$resource` returns the resource of the user

Very advanced chaining DSL !!

`$resource(user).$set(age: 27).$push('projects', project).$delete('project').from('archived-projects').where('oldest')`

Note this part:

`$delete('project').from('archived-projects').where('oldest')`

Here we are taking advantage of a named query.

```
user.$resource.$queries.add = {
  oldest: {date: {$gte: Date() + days(3).before('today')} }
}
```

Please add more thoughts/ideas... :)
