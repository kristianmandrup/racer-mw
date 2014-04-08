# Unnamed pipe

This decorator can be used for any pipe that is unnamed, such as:

- CollectionModel

This decorator simply makes the `setName` function void (no action) and also disables trying to extract
 the name from the incoming arguments, using the name extractor. Instead all the arguments should be parsed as a value via
 the value extractor.