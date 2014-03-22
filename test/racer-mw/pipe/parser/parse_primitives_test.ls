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

  describe 'parse-array' ->
    specify 'string not parsed' ->
      expect(-> parser.parse-array 'name').to.throw

    specify 'string not parsed without key' ->
      expect(-> parser.parse-array ['x', 'y']).to.throw

  describe 'parse-collection' ->
    specify 'string not parsed' ->
      expect(-> parser.parse-collection 'name').to.throw

    specify 'string not parsed without key' ->
      expect(-> parser.parse-collection ['x', 'y']).to.throw

  describe 'list-type' ->
    specify 'empty list: empty' ->
      expect(parser.list-type('x')).to.eql 'empty'

    specify 'empty list: empty' ->
      expect(parser.list-type('x', [])).to.eql 'empty'

    specify 'obj list: collection' ->
      expect(parser.list-type('x', [{x: 1}])).to.eql 'collection'

    specify 'primitive list: array' ->
      expect(parser.list-type('x', [1,2,3])).to.eql 'array'

    specify 'mixed list: mixed' ->
      expect(parser.list-type('x', [1,2,{x: 3}])).to.eql 'mixed'

  describe 'parse-plural' ->
    specify 'empty list: fails' ->
      expect(-> parser.parse-plural('x', [])).to.throw

    specify 'mixed list: mixed' ->
      expect(-> parser.parse-plural('x', [1,2,{x: 3}])).to.throw

  describe 'tupel-type' ->
    specify 'no arg: fails' ->
      expect(-> parser.tupel-type!).to.throw

    specify 'number: fails' ->
      expect(-> parser.tupel-type 3).to.throw

    specify '_users: path' ->
      expect(parser.tupel-type '_users').to.eql 'path'

    specify '$users: path' ->
      expect(parser.tupel-type '$users').to.eql 'path'

    specify 'users: plural' ->
      expect(parser.tupel-type 'users').to.eql 'plural'

    specify 'user: single' ->
      expect(parser.tupel-type 'user').to.eql 'single'

    specify 'xyz: fails' ->
      expect(-> parser.tupel-type 'xyz').to.throw

  describe 'parse-tupel' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-tupel!).to.throw

    specify 'number: fails' ->
      expect(-> parser.parse-tupel 3).to.throw

    specify 'xyz: fails' ->
      expect(-> parser.parse-tupel 'xyz').to.throw

  describe 'parse-object' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-object!).to.throw

    specify 'number: fails' ->
      expect(-> parser.parse-object 3).to.throw

    specify 'string: fails' ->
      expect(-> parser.parse-object 'x').to.throw

  describe 'parse-single' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-single!).to.throw

    specify 'one arg: fails' ->
      expect(-> parser.parse-single 'x').to.throw

    specify 'one arg: user - ok' ->
      expect(-> parser.parse-single 'user').to.not.throw

  describe 'parse-obj' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-obj!).to.throw

    specify 'number: fails' ->
      expect(-> parser.parse-obj 3).to.throw

