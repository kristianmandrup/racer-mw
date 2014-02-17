# Racer Store and Models

On the server, **Racer** creates a store, which manages data updates. Stores create model objects,
which provide a synchronous interface similar to interacting directly with objects.
Models maintain their own copy of a subset of the global state.

This subset is defined via subscriptions to certain paths. Models perform operations independently, and they automatically
synchronize their state with the associated store.

All remotely synced data is stored via ShareJS, which means that different clients can modify the same data at the same
time. **ShareJS** uses **Operational Transformation (OT)** to automatically resolve conflicts and update the view for each client.

Model mutator methods provide callbacks invoked after the server ultimately commits an operation.
These callbacks can be used to wait for the eventual value of an operation before performing further logic,
such as waiting for an increment to get a unique count number. Models also emit events when their contents are
updated, which **Derby** uses to update the view in realtime.

## Creating stores

The default server produced by the Derby project generator will create a store and add a modelMiddleware to the
Express server before any app routers. The modelMiddleware adds a req.getModel() function which can be
called to create or get a model (if one was already created) for a given request.

`store = derby.createStore ( options )`

`options` An object that configures the store

`store` Returns a Racer store object

Typically, a project will have only one store, even if it has multiple apps. It is possible to have multiple stores,
though a given page can only have one model, and a model is associated with one store.