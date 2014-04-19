Class   = require('jsclass/src/core').Class
get     = require '../../../../../../requires' .get!
expect  = require('chai').expect
lo  = require 'lodash'
require 'sugar'

ValueExtractor = get.model-extractor 'value'

describe 'ValueExtractor' ->
  var extractor

  describe 'initialize(@obj)' ->
    specify 'no args - fails' ->
      expect(-> new ValueExtractor).to.throw Error

    specify 'string arg - ok' ->
      expect(-> new ValueExtractor 'x').to.not.throw Error

    specify 'obj args - ok' ->
      expect(-> new ValueExtractor x: 2).to.not.throw Error

    specify 'array args - ok' ->
      expect(-> new ValueExtractor 'x', 3).to.not.throw Error

  context 'instance: x' ->
    before ->
      extractor := new ValueExtractor 'x'

    describe 'extract' ->
      # @string-value or @obj-value!
      specify 'extracts value' ->
        expect(extractor.extract!).to.eql {}

    describe 'string-value' ->
      # return {} if @is-string!
      specify 'is empty obj {}' ->
        expect(extractor.string-value!).to.eql {}

    describe 'obj-value' ->
      # @inner-obj!
      specify 'void' ->
        expect(extractor.obj-value!).to.eql void

  context 'instance: x: 2' ->
    before ->
      extractor := new ValueExtractor 'x': 2

    describe 'extract' ->
      # @string-value or @obj-value!
      specify 'extracts value' ->
        expect(extractor.extract!).to.eql 2

    describe 'string-value' ->
      # return {} if @is-string!
      specify 'void' ->
        expect(extractor.string-value!).to.eql void

    describe 'obj-value' ->
      # @inner-obj!
      specify 'extracts value' ->
        expect(extractor.obj-value!).to.eql 2