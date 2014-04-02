requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeParser      = requires.pipe   'pipe_parser'

ModelPipe       = requires.apipe   'model'
CollectionPipe  = requires.apipe   'collection'
AttributePipe   = requires.apipe   'attribute'
PathPipe        = requires.apipe   'path'

util = require 'util'

# TODO: Clean up tests...
describe 'Parser' ->
  var parser, obj, result, child, children

  objs    = {}
  attrs   = {}

  create-parser = (options) ->
    new PipeParser options

  before ->
    parser  := create-parser!

  describe 'parse' ->
    context 'mixed array of objects + strings ok' ->
      before ->
        result := parser.parse(['email', admin-user: {name: 'kris'}])

      specify 'first is AttributePipe' ->
        expect(result.first!).to.be.an.instance-of AttributePipe

      specify 'last is ModelPipe' ->
        expect(result.last!).to.be.an.instance-of ModelPipe




