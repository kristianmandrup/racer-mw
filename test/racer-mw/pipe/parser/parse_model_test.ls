requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

Parser          = requires.pipe   'pipe_parser'

ModelPipe       = requires.apipe   'model'
CollectionPipe  = requires.apipe   'collection'
AttributePipe   = requires.apipe   'attribute'
PathPipe        = requires.apipe   'path'

util = require 'util'

describe 'Parser' ->
  var parser, obj, result, child, children

  objs    = {}
  attrs   = {}

  before ->
    parser  := new Parser

  describe 'build-model' ->
    specify 'user: void - ok' ->
      expect(parser.build-model 'user', void).to.be.an.instance-of ModelPipe

  describe 'parse-tupel' ->
    specify 'user: single' ->
      expect(parser.parse-tupel 'user').to.be.an.instance-of ModelPipe

  describe 'parse-object' ->
    specify 'admin: object - ok' ->
      expect(parser.parse-object(admin: {name: 'kris'})).to.be.an.instance-of ModelPipe

    specify 'admin: objects - ok' ->
      expect(parser.parse-object(admin: {name: 'kris'}, guest: {name: 'unknown'} ).last!).to.be.an.instance-of ModelPipe

  describe 'parse-single' ->
    describe 'admin: object - ok' ->
      before ->
        result := parser.parse-single 'admin', {name: 'kris'}

      specify 'returns model pipe' ->
        expect(result).to.be.an.instance-of ModelPipe

      specify 'value is name: kris' ->
        expect(result.value-obj.value).to.eql name: 'kris'
