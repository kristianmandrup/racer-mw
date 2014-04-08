# Raw value helpers

## Raw Value Calculator

The main function is `raw-value`, which uses `raw-children-value` if the pipe has children, otherwise just calls `value`.

## Raw extractor

The method `inner-raw` calculates the inner raw value, which is the inner value of the pipe, either `contained-value` or `obj`.
The `contained-value` for a CollectionModel is f.ex `0 : {x: 2}`.


