# MW-Design

This Mw Could simply call `save` (which calls `model.set()`) on any data that goes through and is a
`Resource` that is part of a pipeline! Then call model.get() on the scope (returned by `model.set()`) to get the value
saved, then call Decorate and return this to the client layer, fx Derby or Angular binding layer (controllers).