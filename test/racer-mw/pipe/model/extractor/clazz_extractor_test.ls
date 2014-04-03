Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

ClassExtractor = get.model-extractor 'clazz'

describe 'ClazzExtractor' ->
  describe 'initialize(@obj)' ->

  context 'instance' ->
    describe 'clazz(obj, nested)' ->
      # @str-obj-clazz(nested) or @normalized-obj-clazz! or @recurse-clazz!

    describe 'recurse-clazz' ->
      # @clazz @inner-obj!, true if @inner-obj!

    describe 'str-obj-clazz(nested)' ->
      # @obj if @is-string and not nested

    describe 'normalized-obj-clazz' ->
      # @normalized(@obj._clazz) if @valid-clazz!

    describe 'valid-clazz' ->