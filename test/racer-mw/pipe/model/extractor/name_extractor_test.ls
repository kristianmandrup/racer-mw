Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

NameExtractor = get.base-extractor 'name'

describe 'NameExtractor' ->
  describe 'initialize(@obj)' ->

  context 'instance' ->
    describe 'name' ->
      # @name-from-clazz! or @normalized-name!

    describe 'normalized-name' ->
      # @normalized @str-name! or @first-key!

    describe 'name-from-clazz' ->
      # obj._clazz if @obj._clazz isnt void

    describe 'str-name' ->
      # @obj if @is-string!

    describe 'first-key' ->
      # _.keys(@obj).first!
