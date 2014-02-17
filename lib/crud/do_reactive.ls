# Reactive functions

/*
Reactive functions provide a simple way to update a computed value whenever one or more objects change. While model events respond to specific model methods and path patterns, reactive functions will be re-evaluated whenever any of thier inputs or nested properties change in any way.
They are defined similar to view helper functions, but instead of being used from templates, their outputs are set in the model.
*/

# model.fn ( name, fns )


# To execute a model function, you then call model.evaluate() or model.start().
# Evaluate runs a function once and returns the result, and start sets up event listeners that
# continually re-evaluate the function whenever any of its input or output paths are changed.

# value = model.evaluate ( name, inputPaths..., [options] )
# value = model.start ( name, path, inputPaths..., [options] )
# model.stop ( path )
