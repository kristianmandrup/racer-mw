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

```
model.stringInsert '_page.text-area', 'hello'
```

No collection really. Should allow for this case too! can the text area in this case still have its own validation
In this case `_page` becomes the container ('page' model?).

## More advanced pipelining

From the above analysis we can see the following conclusions taking shape...

We need two middleware pipelines.

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

### Adv. Authorization

`mw-stack('container').authorize.can 'add', data: item, ctx: {container: container, attribute: attribute}`

The key is to allow the developer to configure this as required while facilitating certain common patterns.
We should not apply too strict conventions, at least until we have uncovered typical repetitive usage patterns
that can be encapsulated.

## Resources

As we can now start to see...

```
users = collection('users')
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

page.attribute('current').model(admin-user).set role: 'guest'

# get all admin users since past 3 days
page.collection(admin-user).query $date: {$gte: days(3).before(new Date) }}
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
users.path('current.admin').model(admin-user)

# collection
users-col = {
  $collection: 'users'
  $calc-path: ->
    @collection
}

current-admin-path = {
  $path: 'current.admin'
  $parent: users-col

  # Note: we should only generate this method only when we need it, in one of the Resource methods such as $save!
  $calc-path: ->
    new PathResolver(@).full-path

}

admin-user = {
  $class: 'user'
  $parent: current-admin-path
}
```

So we need a PathResolver to resolve the full path at each step in the hierarchy.
This way we extract this functionality (Single Responsibility) and avoid cluttering
 each Resource with source logic

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
