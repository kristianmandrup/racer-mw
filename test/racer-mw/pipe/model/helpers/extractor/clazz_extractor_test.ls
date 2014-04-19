Class   = require('jsclass/src/core').Class
get     = require '../../../../../../requires' .get!
expect  = require('chai').expect
lo      = require 'lodash'
require 'sugar'

ClazzExtractor = get.model-extractor 'clazz'

describe 'ClazzExtractor' ->
  describe 'initialize(@obj)' ->
    specify 'no args - fails' ->
      expect(-> new ClazzExtractor).to.throw Error

    specify 'String arg - ok' ->
      expect(-> new ClazzExtractor 'x').to.not.throw Error

    specify 'Object args - ok' ->
      expect(-> new ClazzExtractor x: 2).to.not.throw Error

  context 'instance: x: 2' ->
    var extractor
    before-each ->
      extractor := new ClazzExtractor x: 2

    describe 'extract' ->
      # @str-obj-clazz(nested) or @normalized-obj-clazz! or @recurse-clazz!
      specify 'no class - throws' ->
        expect(-> extractor.extract!).to.throw Error

    describe 'is-object' ->
      specify 'yes' ->
        expect(extractor.is-object!).to.be.true

    describe 'inner-obj' ->
      specify 'void' ->
        expect(extractor.inner-obj!).to.eql void

    describe 'recurse-clazz' ->
      specify 'not a class - void' ->
        expect(extractor.recurse-clazz!).to.eql void

    describe 'str-obj-clazz' ->
      # @obj if @is-string and not nested
      specify 'is void' ->
        expect(extractor.str-obj-clazz!).to.eql void

    describe 'obj-clazz' ->
      # @normalized(@obj._clazz) if @valid-clazz!
      specify 'void since not a valid clazz' ->
        expect(extractor.obj-clazz!).to.eql void

    describe 'valid-clazz' ->
      specify 'invalid' ->
        expect(extractor.valid-clazz!).to.not.be.ok

  context "instance: {_clazz: 'user'}" ->
    var extractor
    before-each ->
      extractor := new ClazzExtractor {_clazz: 'user'}

    describe 'extract' ->
      # @str-obj-clazz(nested) or @normalized-obj-clazz! or @recurse-clazz!
      specify 'is user' ->
        expect(extractor.extract!).to.eql 'user'

    describe 'is-object' ->
      specify 'yes' ->
        expect(extractor.is-object!).to.be.true

    describe 'inner-obj' ->
      specify 'void' ->
        expect(extractor.inner-obj!).to.eql void

    describe 'recurse-clazz' ->
      specify 'not a class - void' ->
        expect(extractor.recurse-clazz!).to.eql void

    describe 'str-obj-clazz(nested)' ->
      # @obj if @is-string and not nested
      specify 'nested - void' ->
        expect(extractor.str-obj-clazz!).to.eql void

      specify 'not nested - void' ->
        expect(extractor.str-obj-clazz!).to.eql void

    describe 'obj-clazz' ->
      # @normalized(@obj._clazz) if @valid-clazz!
      specify 'user since a valid clazz' ->
        expect(extractor.obj-clazz!).to.eql 'user'

    describe 'valid-clazz' ->
      specify 'valid' ->
        expect(extractor.valid-clazz!).to.be.ok

  context "instance: {_clazz: 'user'}" ->
    var extractor, obj

    before-each ->
      obj :=
        admin:
          _clazz: 'user'

      extractor := new ClazzExtractor obj

    describe 'extract' ->
      # @str-obj-clazz(nested) or @normalized-obj-clazz! or @recurse-clazz!
      specify 'is user' ->
        expect(extractor.extract!).to.eql 'user'

    describe 'is-object' ->
      specify 'yes' ->
        expect(extractor.is-object!).to.be.true

    describe 'inner-obj' ->
      specify 'to be clazz' ->
        expect(extractor.inner-obj!).to.eql {_clazz: 'user'}

    describe 'recurse-clazz' ->
      specify 'is user' ->
        expect(extractor.recurse-clazz!).to.eql 'user'

    describe 'str-obj-clazz' ->
      # @obj if @is-string and not nested
      specify 'is void' ->
        expect(extractor.str-obj-clazz!).to.eql void

    describe 'obj-clazz' ->
      # @normalized(@obj._clazz) if @valid-clazz!
      specify 'since not recursed' ->
        expect(extractor.obj-clazz!).to.eql void

    describe 'valid-clazz' ->
      specify 'invalid since not recursed' ->
        expect(extractor.valid-clazz!).to.be.false