requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeParser      = requires.pipe!base!file   'pipe_parser'

pipe = ->
  requires.pipe!.named

ModelPipe       = pipe 'model'
CollectionPipe  = pipe 'collection'
AttributePipe   = pipe 'attribute'
PathPipe        = pipe 'path'

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




