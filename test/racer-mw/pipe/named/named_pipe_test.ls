Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!

get.test 'test_setup'

expect          = require('chai').expect

NamedPipe       = get.apipe 'named'



BasicNamedPipe = new Class(
  include: NamedPipe
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

