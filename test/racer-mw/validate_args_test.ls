requires = require '../../requires'

requires.test 'test_setup'

expect = require('chai').expect

ValidateArgs = requires.lib 'validate_args'

Class         = require('jsclass/src/core').Class
lo            = require 'lodash'
_             = require 'prelude-ls'
require 'sugar'

errors                    = requires.lib 'errors'
ArgumentError             = errors.ArgumentError
InvalidTypeError          = errors.InvalidTypeError
RequiredArgumentError     = errors.RequiredArgumentError

Validator = new Class(
  include: ValidateArgs
)

describe 'ValidateArgs' ->
  var validator

  before ->
    validator := new Validator

  describe 'type-msg' ->
    specify 'number - a' ->
      expect(validator.type-msg 'number').to.equal "a number"

    specify 'number, string - one of number, string' ->
      expect(validator.type-msg ['number', 'string']).to.equal "one of: number,string"

  describe 'unpack hash' ->
    specify 'string x' ->
      expect(validator.unpack 'x').to.include 'x', void

    specify 'hash x: 6' ->
      expect(validator.unpack x: 6).to.include 'x', 6

  describe 'type-error' ->
    specify 'throws InvalidTypeError' ->
      expect( -> validator.type-error index: 'number', 'song').to.throw new InvalidTypeError

  describe 'missing' ->
    specify 'throws ArgumentError' ->
      expect( -> validator.missing 'index', name: 'kris').to.throw new ArgumentError

  describe 'validate-missing' ->
    specify 'throws ArgumentError' ->
      expect( -> validator.validate-missing index: void, {name: 'kris'}).to.throw new ArgumentError

  describe 'validate-type' ->
    specify 'throws InvalidTypeError' ->
      expect( -> validator.validate-type index: 'number', 'kris').to.throw new InvalidTypeError

  describe 'validate-required' ->
    specify 'throws RequiredArgumentError' ->
      expect( -> validator.validate-required index: 'number', 'kris', {name: 'kris'}).to.throw new RequiredArgumentError

