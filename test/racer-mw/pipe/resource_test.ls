Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeResource    = requires.pipe   'resource'

PipeWithNoType = new Class(
  include: PipeResource

  initialize: ->
    @
)

PipeWithResource = new Class(
  include: PipeResource

  initialize: ->
    @

  type: 'Pipe'
  pipe-type: 'Model'
)

PipeWithNoResource = new Class(
  include: PipeResource

  initialize: ->
    @

  has-resource: false
)


describe 'PipeResource' ->
  var pipe, result

  context 'pipe with no type' ->
    before ->
      pipe := new PipeWithNoType

    describe 'create-res' ->
      specify 'returns void' ->
        expect(-> pipe.create-res!).to.throw Error

  context 'pipe with No resource' ->
    before ->
      pipe := new PipeWithNoResource

    describe 'has-resource' ->
      specify 'is true' ->
        expect(pipe.has-resource).to.be.false

    describe 'create-res' ->
      before ->
        result := pipe.create-res!

      specify 'returns void' ->
        expect(result).to.be.undefined

      specify 'pipe still has no $res' ->
        expect(pipe.$res).to.be.undefined

  context 'pipe with resource' ->
    before ->
      pipe := new PipeWithResource

    describe 'has-resource' ->
      specify 'is true' ->
        expect(pipe.has-resource).to.be.true

    describe 'create-res' ->
      before ->
        result := pipe.create-res!

      specify 'returns something' ->
        expect(result).to.not.be.undefined

      specify 'pipe assigned a $res' ->
        expect(pipe.$res).to.not.be.undefined
