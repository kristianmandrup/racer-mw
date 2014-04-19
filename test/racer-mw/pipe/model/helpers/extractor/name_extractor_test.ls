Class   = require('jsclass/src/core').Class
get     = require '../../../../../../requires' .get!
expect  = require('chai').expect
lo  = require 'lodash'
require 'sugar'

NameExtractor = get.model-extractor 'name'

describe 'NameExtractor' ->
  var extractor

  describe 'initialize(@obj)' ->
    specify 'no args - fails' ->
      expect(-> new NameExtractor).to.throw Error

  context 'instance: x' ->
    before ->
      extractor := new NameExtractor 'x'

    describe 'extract' ->
      # @name-from-clazz! or @normalized-name!
      specify 'extracts name' ->
        expect(extractor.extract!).to.eql 'x'

    describe 'normalized-name' ->
      # @normalized @str-name! or @first-key!
      specify 'extracts name' ->
        expect(extractor.normalized-name!).to.eql 'x'

    describe 'name-from-clazz' ->
      # obj._clazz if @obj._clazz isnt void
      specify 'extracts name' ->
        expect(extractor.name-from-clazz!).to.be.undefined

    describe 'str-name' ->
      # @obj if @is-string!
      specify 'extracts name from string' ->
        expect(extractor.str-name!).to.eql 'x'

  context 'instance: x' ->
    before ->
      extractor := new NameExtractor _clazz: 'user'

    describe 'name-from-clazz' ->
      # obj._clazz if @obj._clazz isnt void
      specify 'extracts name' ->
        expect(extractor.name-from-clazz!).to.eql 'user'
