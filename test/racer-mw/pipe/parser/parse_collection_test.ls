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

  describe 'parse-collection' ->
    specify 'parsed into a Collection pipe' ->
      expect(parser.parse-collection 'users', [{name: 'kris'}]).to.be.an.instance-of CollectionPipe

  describe 'parse-plural' ->
    specify 'obj list: collection' ->
      expect(parser.parse-plural('x', [{x: 1}])).to.be.an.instance-of CollectionPipe

  describe 'build-collection' ->
    specify 'users: void - ok' ->
      expect(parser.build-collection 'users', void).to.be.an.instance-of CollectionPipe

  describe 'parse-tupel' ->
    specify 'users: plural' ->
      expect(parser.parse-tupel 'users').to.be.an.instance-of CollectionPipe
