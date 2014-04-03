Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

ClassExtractor = get.model-extractor 'clazz'

describe 'ClazzExtractor' ->
  describe 'initialize(@obj)' ->
    specify 'no args - fails' ->
      expect(-> new ClazzExtractor).to.throw Error

    specify 'String arg - ok' ->
      expect(-> new ClazzExtractor 'x').to.not.throw Error

    specify 'Object args - ok' ->
      expect(-> new ClazzExtractor x: 2).to.not.throw Error

  context 'instance' ->
    var extractor
    before ->
      extractor := new ClazzExtractor x: 2

    describe 'clazz(obj, nested)' ->
      # @str-obj-clazz(nested) or @normalized-obj-clazz! or @recurse-clazz!
      specify 'find class, nested' ->
        expect(extractor.clazz {x: 2}, true).to.eql 'x'

    describe 'recurse-clazz' ->
      # @clazz @inner-obj!, true if @inner-obj!
      specify 'finds class' ->
        expect(extractor.recurse-clazz!).to.eql 'x'

    describe 'str-obj-clazz(nested)' ->
      # @obj if @is-string and not nested
      specify 'nested - finds x' ->
        expect(extractor.str-obj-clazz true).to.eql 'x'

      specify 'not nested - finds ?' ->
        expect(extractor.str-obj-clazz false).to.eql 'y'

    describe 'normalized-obj-clazz' ->
      # @normalized(@obj._clazz) if @valid-clazz!
      specify 'not nested - finds ?' ->
        expect(extractor.normalized-obj-clazz!).to.eql 'y'


    describe 'valid-clazz' ->
      specify 'valid when ...' ->
        expect(extractor.valid-clazz!).to.be.ok

      specify 'invalid when ...' ->
        expect(extractor.valid-clazz!).to.not.be.ok
