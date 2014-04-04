/**
 * User: kmandrup
 * Date: 08/03/14
 * Time: 12:49
 */
Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeAttacher  = requires.pipe 'pipe_attacher'
PipeInspector = requires.pipe 'pipe_inspector'
PipeFamily    = requires.pipe 'pipe_family'

BasicPipe = new Class(
  initialize: (@name) ->
    @

  include:
    * PipeAttacher
    * PipeInspector
    * PipeFamily

  id: ->
    'basic'

  children: {}
  update-name: ->

  pre-attach-to: (p) ->

  valid-children:
    * \attribute
    * \model
    * \collection

  valid-child: (name) ->
    name in @valid-children

  type: 'Pipe'
  pipe-type: 'Path'
)


describe 'PipeAttacher' ->
  var pipe

  pipes = {}

  context 'Basic pipe' ->
    before ->
      pipes.grand-pere  := new BasicPipe 'grand daddy O!'
      pipes.daddy       := new BasicPipe 'parent'
      pipes.node        := new BasicPipe 'hello'
      pipe              := pipes.node

      pipes.other       := new BasicPipe 'other side'

      # cheating for setup ;)
      pipes.node.parent  = pipes.daddy
      pipes.daddy.parent = pipes.grand-pere

    describe 'attach' ->
      specify 'throws when no args' ->
        expect(-> pipe.attach!).to.throw Error

      specify 'throws when not an object' ->
        expect(-> pipe.attach 'x').to.throw Error

      specify 'throws when not a Pipe object' ->
        expect(-> pipe.attach {}).to.throw Error

      specify 'throws when only type: Pipe' ->
        expect(-> pipe.attach type: 'Pipe').to.throw Error

      specify 'throws when attaching self' ->
        expect(-> pipe.attach pipe).to.throw Error

      specify 'throws when attaching any ancestor pipe (circular)' ->
        expect(-> pipe.attach pipes.grand-pere).to.throw Error

      specify 'ok when another Pipe' ->
        expect(-> pipe.attach pipes.other).to.not.throw
