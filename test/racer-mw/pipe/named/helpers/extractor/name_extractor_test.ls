get     = require '../../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

NameExtractor   = get.named-extractor 'name'

describe 'NameExtractor - basic' ->
  var extractor, res

  describe 'initialize(...args)' ->
    specify 'no args - ok' ->
      expect(-> new NameExtractor).to.not.throw Error

  describe 'instance' ->
    specify 'no args - fails' ->
      expect(-> new NameExtractor.extract!).to.throw Error

    specify 'String arg - ok' ->
      expect(-> new NameExtractor 'x' .extract!).to.not.throw Error

    specify 'Object arg - ok' ->
      expect(-> new NameExtractor x: 2 .extract!).to.not.throw Error
