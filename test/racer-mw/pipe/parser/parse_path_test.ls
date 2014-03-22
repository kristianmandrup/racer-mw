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

  describe 'parse-tupel' ->
    specify '_users: path' ->
      expect(parser.parse-tupel '_users').to.be.an.instance-of PathPipe

    specify '$users: path' ->
      expect(parser.parse-tupel '$users').to.be.an.instance-of PathPipe

  describe 'parse-path' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-path!).to.throw

    specify '_page: PathPipe' ->
      expect(parser.parse-path '_page').to.be.an.instance-of PathPipe

    specify '_page: x - fails' ->
      expect(-> parser.parse-path '_page', 'x').to.throw

    specify '_page: object - ok' ->
      expect(parser.parse-path '_page', {x: 1}).to.be.an.instance-of PathPipe
