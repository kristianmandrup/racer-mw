Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

ValueExtractor = get.base-extractor 'value'

describe 'ValueExtractor' ->
  describe 'initialize(@obj)' ->

  context 'instance' ->
    describe 'value' ->
      # @string-value or @obj-value!

    describe 'string-value' ->
      # return {} if @is-string!

    describe 'obj-value' ->
      # @inner-obj!
