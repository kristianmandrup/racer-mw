# Child modules

The following Child modules contain modules can be added to any child pipe to decorate it with specific functionality.

- Naming
- Navigation
- Notification

## Naming

Decorates the pipe with functionality to update its full name when its local name is set.
It employs a NameHelper to perform this job.

- setName
- updateFullName

## Navigation

Decorates the pipe with functionality to navigate up its ancestor pipes.

- prev
- root

## Notification

Decorates the pipe with functionality to notify its parent pipe that its value has changed.
This is in order that the parent pipe can recalculate and cache a new updated value based on its child values.

Note: Currently this value updating/caching strategy is rather naive (simple) and needs some optimization, such
as only recalculating the value based on dirty children (i.e children notifying a change).
Also needs to use an Async strategy, perhaps using Harmony generators!

- onChildUpdate
