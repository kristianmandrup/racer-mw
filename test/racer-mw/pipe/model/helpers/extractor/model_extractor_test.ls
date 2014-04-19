Class   = require('jsclass/src/core').Class
get     = require '../../../../../../requires' .get!
expect  = require('chai').expect
lo      = require 'lodash'
require 'sugar'

ModelExtractor  = get.model-extractor 'model'
NameExtractor   = get.model-extractor 'name'
ClazzExtractor  = get.model-extractor 'clazz'
ValueExtractor  = get.model-extractor 'value'

describe 'ModelExtractor' ->
  var pipe, obj, model-extractor, extract

  context 'empty obj' ->
    describe 'create' ->
      specify 'throws' ->
        expect(-> new ModelExtractor {}).to.throw Error

  context 'empty string' ->
    before ->
      model-extractor := new ModelExtractor ''

    describe 'name-extractor' ->
      specify 'returns instance' ->
        expect(model-extractor.name-extractor!).to.be.an.instance-of NameExtractor

    describe 'value-extractor' ->
      specify 'returns instance' ->
        expect(model-extractor.value-extractor!).to.be.an.instance-of ValueExtractor

    describe 'clazz-extractor' ->
      specify 'returns instance' ->
        expect(model-extractor.clazz-extractor!).to.be.an.instance-of ClazzExtractor

    describe 'name' ->
      specify 'throws' ->
        expect(-> model-extractor.name!).to.throw Error

    describe 'value' ->
      specify 'throws' ->
        expect(-> model-extractor.value!).to.not.throw Error

    describe 'clazz' ->
      specify 'throws' ->
        expect(-> model-extractor.clazz!).to.throw Error

    describe 'extract' ->
      specify 'throws' ->
        expect(-> model-extractor.extract!).to.throw Error

  context 'string: x' ->
    before ->
      model-extractor := new ModelExtractor 'x'

    describe 'name' ->
      specify 'is x' ->
        expect(model-extractor.name!).to.eql 'x'

    describe 'value' ->
      specify 'throws' ->
        expect(model-extractor.value!).to.eql {}

    describe 'clazz' ->
      specify 'throws' ->
        expect(model-extractor.clazz!).to.eql 'x'

    describe 'extract' ->
      specify 'throws' ->
        expect(model-extractor.extract!).to.eql name: 'x', value: {}, clazz: 'x'

  context 'obj with void clazz' ->
    before ->
      model-extractor := new ModelExtractor {_clazz: void}

    describe 'name' ->
      specify 'is x' ->
        expect(-> model-extractor.name!).to.throw Error

    describe 'value' ->
      specify 'throws' ->
        expect(-> model-extractor.value!).to.throw Error

    describe 'clazz' ->
      specify 'throws' ->
        expect(-> model-extractor.clazz!).to.throw Error

    describe 'extract' ->
      specify 'throws' ->
        expect(-> model-extractor.extract!).to.throw Error

  context 'obj with empty clazz' ->
    before ->
      model-extractor := new ModelExtractor {_clazz: ''}

    describe 'name' ->
      specify 'is x' ->
        expect(-> model-extractor.name!).to.throw Error

    describe 'value' ->
      specify 'throws' ->
        expect(-> model-extractor.value!).to.throw Error

    describe 'clazz' ->
      specify 'throws' ->
        expect(-> model-extractor.clazz!).to.throw Error

    describe 'extract' ->
      specify 'throws' ->
        expect(-> model-extractor.extract!).to.throw Error

  context 'obj with clazz: user' ->
    before ->
      obj := {_clazz: 'user'}
      model-extractor := new ModelExtractor obj

    describe 'name' ->
      specify 'is user' ->
        expect(model-extractor.name!).to.eql 'user'

    describe 'value' ->
      specify 'is the obj' ->
        expect(model-extractor.value!).to.eql obj

    describe 'clazz' ->
      specify 'is user' ->
        expect(model-extractor.clazz!).to.eql 'user'

    describe 'extract' ->
      specify 'throws' ->
        expect(model-extractor.extract!).to.not.be.undefined

  context.only 'admin obj with clazz: user' ->
    before ->
      obj :=
        admin:
          _clazz: 'user'
      model-extractor := new ModelExtractor obj

    describe 'name' ->
      specify 'is user' ->
        expect(model-extractor.name!).to.eql 'admin'

    describe 'value' ->
      specify 'is the obj' ->
        expect(model-extractor.value!).to.eql {_clazz: 'user'}

    describe.only 'clazz' ->
      specify 'is user' ->
        expect(model-extractor.clazz!).to.eql 'user'

    describe 'extract' ->
      specify 'throws' ->
        expect(model-extractor.extract!).to.not.be.undefined
