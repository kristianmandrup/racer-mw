Class   = require('jsclass/src/core').Class
get     = require '../../../../../../requires' .get!
expect  = require('chai').expect
lo      = require 'lodash'
require 'sugar'

BaseExtractor = get.model-extractor 'base'

describe 'BaseExtractor' ->
  describe 'initialize(@obj)' ->
    specify 'no args - fails' ->
      expect(-> new BaseExtractor).to.throw Error

    specify 'String arg - ok' ->
      expect(-> new BaseExtractor 'x').to.not.throw Error

    specify 'Object args - ok' ->
      expect(-> new BaseExtractor x: 2).to.not.throw Error

  context 'instance' ->
    var extractor
    before ->
      extractor := new BaseExtractor x: 2

    describe 'inner-obj' ->
      # @inner ||= @values!.first!
      specify 'has inner: 2' ->
        expect(extractor.inner-obj!).to.eql 2

    describe 'values' ->
      # _.values @obj
      specify 'has [2]' ->
        expect(extractor.values!).to.eql [2]

    describe 'first-key' ->
      # _.keys(@obj).first!
      specify 'finds: x' ->
        expect(extractor.first-key!).to.eql 'x'

    describe 'normalized(val)' ->
      # val if lo.is-empty val
      specify '[] becomes void' ->
        expect(extractor.normalized []).to.eql void

    describe 'is-string' ->
      # typeof! @obj is 'String'
      specify 'is false' ->
        expect(extractor.is-string!).to.be.false

    describe 'is-object' ->
      # typeof! @obj is 'Object'
      specify 'is true' ->
        expect(extractor.is-object!).to.be.true
