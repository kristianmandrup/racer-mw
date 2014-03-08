requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

extract   = requires.apipe-extractor 'model'

describe 'ModelPipeExtractor' ->
  var pipe, obj

  context 'empty obj' ->
    before ->
      obj := {}

    describe 'extract' ->
      specify 'value - fails' ->
        expect(-> extract.value obj).to.throw

      specify 'clazz - fails' ->
        expect(-> extract.clazz obj).to.throw

      specify 'name - fails' ->
        expect(-> extract.name obj).to.throw

  context 'empty string' ->
    before ->
      obj := ''

    describe 'extract' ->
      specify 'value - fails' ->
        expect(-> extract.value obj).to.throw

      specify 'clazz - fails' ->
        expect(-> extract.clazz obj).to.throw

      specify 'name - fails' ->
        expect(-> extract.name obj).to.throw

  context 'string: x' ->
    before ->
      obj := 'x'

    describe 'extract' ->
      specify 'value - fails' ->
        expect(-> extract.value obj).to.throw

      specify 'clazz: x' ->
        expect(extract.clazz obj).to.eq 'x'

      specify 'name: x' ->
        expect(extract.name obj).to.eq 'x'

  context 'obj with void clazz' ->
    before ->
      obj := {_clazz: void}

    describe 'extract' ->
      specify 'value - fails' ->
        expect(-> extract.value obj).to.throw

      specify 'clazz - fails' ->
        expect(-> extract.clazz obj).to.throw

      specify 'name - fails' ->
        expect(-> extract.name obj).to.throw

  context 'obj with empty clazz' ->
    before ->
      obj := {_clazz: ''}

    describe 'extract' ->
      specify 'value - fails' ->
        expect(-> extract.value obj).to.throw

      specify 'clazz - fails' ->
        expect(-> extract.clazz obj).to.throw

      specify 'name - fails' ->
        expect(-> extract.name obj).to.throw

  context 'obj with clazz: user' ->
    before ->
      obj := {_clazz: 'user'}

    describe 'extract' ->
      specify 'value - fails' ->
        expect(-> extract.value obj).to.not.throw

      specify 'clazz: user' ->
        expect(extract.clazz obj).to.eq 'user'

      specify 'name: undefined' ->
        expect(extract.name obj).to.be.undefined

  context 'admin obj with clazz: user' ->
    before ->
      obj :=
        admin:
          _clazz: 'user'

    describe 'extract' ->
      specify 'value is named obj' ->
        expect(extract.value obj).to.eql {_clazz: 'user'}

      specify 'clazz: user' ->
        expect(extract.clazz obj).to.eq 'user'

      specify 'name: admin' ->
        expect(extract.name obj).to.eq 'admin'
