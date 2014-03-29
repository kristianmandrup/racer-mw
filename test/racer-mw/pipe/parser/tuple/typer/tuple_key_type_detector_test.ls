requires = require '../../../../../../requires'

requires.test 'test_setup'
expect      = require('chai').expect
require 'sugar'

TupleKeyTypeDetector = requires.pipe 'parser/tuple/typer/tuple_key_type_detector'

describe 'TupleKeyTypeDetector' ->
  var detector

  describe 'initialize(@type)' ->
    # @build-type-detectors!
    specify 'no args - fails' ->
      expect(-> new TupleKeyTypeDetector).to.throw TypeError

    specify 'Object arg - fails' ->
      expect(-> new TupleKeyTypeDetector x:2).to.throw TypeError

    specify 'String arg - ok' ->
      expect(-> new TupleKeyTypeDetector 'x').to.not.throw TypeError

  describe 'instance' ->
    before ->
      detector := new TupleKeyTypeDetector 'single'

    specify "of TupleKeyTypeDetector" ->
      expect(detector).to.be.an.instance-of TupleKeyTypeDetector

    specify "set type capitalized" ->
      expect(detector.type).to.eql 'Single'

    describe 'matches-type(key-type)' ->
      # @["is#{key-type.capitalize!}"]! is @type
      specify 'single: yes' ->
        expect(detector.matches-type 'single').to.be.ok

      specify 'plural: no' ->
        expect(detector.matches-type 'plural').to.not.be.ok

      specify 'first key-types: single' ->
        expect(detector.matches-type detector.key-types.first!).to.be.ok

    describe '_find-tuple-type' ->
      # _.find @type-is, @key-types
      specify 'single: yes' ->
        expect(detector._find-tuple-type!).to.eql 'single'


    describe 'find-tuple-type' ->
      # _.find @type-is, @key-types
      specify 'single: yes' ->
        expect(detector.find-tuple-type!).to.eql 'single'


