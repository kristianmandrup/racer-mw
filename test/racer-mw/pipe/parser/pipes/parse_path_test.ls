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

  context 'page w 2 attributes' ->
    before ->
      objs.page    :=
        _page:
          user-count: 2
          status: 'loading'

      parser  := create-parser!
      result := parser.parse objs.page

    specify 'is parsed as Path' ->
      expect(result).to.be.an.instance-of PathPipe

  context 'model w 2 model attributes' ->
    before ->
      objs.page    :=
        guest:
          uncle:
            name: 'mike'
          mother:
            name: 'ursula'

      parser  := create-parser!
      result := parser.parse objs.page

    specify 'is parsed as Model' ->
      expect(result).to.be.an.instance-of ModelPipe

    specify 'is parsed' ->
      expect(result).to.be.an.instance-of ModelPipe