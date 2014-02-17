Module      = require('jsclass/src/core').Module

requires    = require '../../requires'
lo          = require 'lodash'
_           = require 'prelude-ls'


/*
Model mutator events

Racer emits events whenever it mutates data via model.set, model.push, etc.
It also emits events when data is remotely updated via a subscription.
These events provide an entry point for an app to react to a specific data mutation or
pattern of data mutations. The events might not be exactly the same as the methods that created them,
since they can be transformed via OT.
model.on and model.once accept a second argument for these types of events.
The second argument is a path pattern that will filter emitted events, calling the handler function
only when a mutator matches the pattern. Path patterns support a single segment wildcard (*)
anywhere in a path, and a multi-segment wildcard (**) at the end of the path.
The multi-segment wildcard alone ('**') matches all paths.
*/

OnEvent = Module(

# listener = model.on ( method, path, eventCallback )
  on: (method, event-cb) ->
    @perform 'on', method, event-cb


/*
The event callback receives a number of arguments based on the path pattern and method. The arguments are:

eventCallback ( captures..., [event], args..., passed )

captures: The path segment or segments that match the wildcards in the path pattern

event: The 'all' event adds the emitted event name after the captures and before the args

args: Event specific arguments. See below

passed: An object with properties provided via model.pass. See description below  */

/*
Model mutator event arguments

changeEvent ( captures..., value, previous, passed )

value: The current value at the path that was changed. Will be undefined for objects that were deleted

previous: The previous value at the path. Will be undefined for paths set for the first time

insertEvent ( captures..., index, values, passed )

index: The index at which items were inserted

values: An array of values that were inserted. Always an array, even if only one item was pushed, unshifted, or inserted

removeEvent ( captures..., index, removed, passed )

value: The current value at the path that was changed. Will be undefined for objects that were deleted

removed: An array of values that were removed. Always an array, even if only one item was popped, shifted, or removed

moveEvent ( captures..., from, to, howMany, passed )

from: The index from which items were moved

to: The index to which items were moved

howMany: How many items were moved

stringInsertEvent ( captures..., index, text, passed )

index: The character index within the string at which text was inserted

text: The string that was inserted

stringRemoveEvent ( captures..., index, howMany, passed )

index: The index within the string at which characters were removed

howMany: How many characters were removed

loadEvent ( captures..., document, passed )

document: This event fires when a document is loaded via a subscription or fetch. It emits the value of the newly loaded document object

unloadEvent ( captures..., previousDocument, passed )

previousDocument: This event fires when a document is removed from the model via unsubscribe or unfetch. It emits the value of the document object that was unloaded
*/