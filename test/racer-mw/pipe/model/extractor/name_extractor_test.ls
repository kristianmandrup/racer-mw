Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

NameExtractor = get.base-extractor 'name'

describe 'NameExtractor' ->
  var extractor

  describe 'initialize(@obj)' ->
    specify 'no args - fails' ->
      expect(-> new NameExtractor).to.throw Error

  context 'instance' ->
    before ->
      extractor := new NameExtractor 'x'

    describe 'extract' ->
      # @name-from-clazz! or @normalized-name!
      specify 'extracts name' ->
        expect(extractor.extract!).to.be 'x'

    describe 'normalized-name' ->
      # @normalized @str-name! or @first-key!
      specify 'extracts name' ->
        expect(extractor.normalized-name!).to.be 'x'

    describe 'name-from-clazz' ->
      # obj._clazz if @obj._clazz isnt void
      specify 'extracts name' ->
        expect(extractor.name-from-clazz!).to.be 'x'

    describe 'str-name' ->
      # @obj if @is-string!
      specify 'extracts name from string' ->
        expect(extractor.str-name!).to.be 'x'

    describe 'first-key' ->
      # _.keys(@obj).first!
      specify 'finds: x' ->
        expect(extractor.first-key!).to.be 'x'
