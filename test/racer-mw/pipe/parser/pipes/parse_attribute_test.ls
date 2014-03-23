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

  create-parser = (options) ->
    new PipeParser options

  before ->
    parser  := create-parser!

  describe 'parse-str' ->
    specify 'parsed into an Attribute pipe' ->
      expect(parser.parse-str 'name').to.be.an.instance-of AttributePipe

  describe 'parse-array' ->
    specify 'parsed into an Attribute pipe' ->
      expect(parser.parse-array 'names', ['x', 'y']).to.be.an.instance-of AttributePipe

  describe 'parse-plural' ->
    specify 'primitive list: array' ->
      expect(parser.parse-plural('x', [1,2,3])).to.be.an.instance-of AttributePipe

  describe 'parse-obj' ->
    specify 'string: ok' ->
      expect(parser.parse-obj 'x').to.be.an.instance-of AttributePipe

    specify 'name: kris - ok' ->
      expect(parser.parse-obj name: 'kris').to.be.an.instance-of AttributePipe

    specify 'userCount: 2 - ok' ->
      expect(parser.parse-obj userCount: 2).to.be.an.instance-of AttributePipe

    specify 'array of strings ok' ->
      expect(parser.parse-obj(['name', 'email']).first!).to.be.an.instance-of AttributePipe

    specify 'array of objects ok' ->
      expect(parser.parse-obj([{name: 'kris'}]).first!).to.be.an.instance-of AttributePipe
