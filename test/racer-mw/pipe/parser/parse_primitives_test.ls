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
    specify 'string not parsed' ->
      expect(-> parser.parse-collection 'name').to.throw

    specify 'string not parsed without key' ->
      expect(-> parser.parse-collection ['x', 'y']).to.throw

  describe 'parse-plural' ->
    specify 'empty list: fails' ->
      expect(-> parser.parse-plural('x', [])).to.throw

    specify 'mixed list: mixed' ->
      expect(-> parser.parse-plural('x', [1,2,{x: 3}])).to.throw

  describe 'parse-object' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-object!).to.throw

    specify 'number: fails' ->
      expect(-> parser.parse-object 3).to.throw

    specify 'string: fails' ->
      expect(-> parser.parse-object 'x').to.throw

  describe 'parse-obj' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-obj!).to.throw

    specify 'number: fails' ->
      expect(-> parser.parse-obj 3).to.throw

