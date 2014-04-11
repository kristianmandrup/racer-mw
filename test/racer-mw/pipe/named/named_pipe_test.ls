Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!

get.test 'test_setup'

expect          = require('chai').expect

NamedPipe       = get.apipe 'named'

BasicNamedPipe = new Class(
  include: NamedPipe

  type: 'Pipe'
  info:
    type: 'ArgPipe'

  set-name: (@name) ->
    @
)

NameExtractor = get.named-extractor 'name'

RealNamedPipe = new Class(
  include: NamedPipe

  type: 'Pipe'
  info:
    type: 'ArgPipe'

  name-extractor: ->
    new NameExtractor @

  set-name: (@name) ->
    throw new Error "Name not valid, #{@name}" unless @name
    @
)


describe 'NamedPipe decorator' ->
  var pipe, res

  describe 'initialize(...args)' ->
    # @call-super!
    specify 'no args - fails' ->
      expect(-> new BasicNamedPipe).to.throw Error

  context 'instance - basic' ->
    before ->
      pipe := new BasicNamedPipe 'users'
      res := pipe.set-name 'hello'

    describe 'set-name(name)' ->
      specify 'returns pipe' ->
        expect(res).to.eq pipe

      specify 'sets name of pipe' ->
        expect(pipe.name).to.eql 'hello'

  context 'instance - real' ->
    before ->
      pipe := new RealNamedPipe users: {x: 2}
      res := pipe.name-extractor!extract-and-set!

    describe 'set-name(name)' ->
      specify 'returns pipe' ->
        expect(res).to.eq pipe

      specify 'sets name of pipe' ->
        expect(pipe.name).to.eql 'users'
