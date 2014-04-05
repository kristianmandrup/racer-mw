Class  = require('jsclass/src/core').Class
get    = require '../../../../../requires' .get!
expect = require('chai').expect
get.test 'test_setup'

_ = require 'prelude-ls'

CleanSlate        = get.base-module 'clean_slate'

NamedPipe = new Class(
  include: CleanSlate

  name: 'kris'
  type: 'Pipe'
  pipe:
    type: 'Model'
)

PipeNameHelper    = get.base-helper 'name'

describe 'PipeNameHelper' ->
  var helper, pipe
  before ->
    pipe := new NamedPipe 'kris'

  describe 'initialize(@pipe)' ->
    # @name = @pipe.name
    specify 'no args - fails' ->
      expect(-> new PipeNameHelper).to.throw Error

    specify 'no pipe - fails' ->
      expect(-> new PipeNameHelper 'x').to.throw Error

    specify 'pipe arg - ok' ->
      expect(new PipeNameHelper pipe).to.not.throw Error

  context 'instance' ->
    before ->
      helper := new PipeNameHelper pipe

    describe 'name' ->
      specify 'name: kris' ->
        expect(helper.name).to.eql 'kris'

    describe 'full-name' ->
      # @names!.join '.'
      specify 'name: kris' ->
        expect(helper.full-name!).to.eql 'kris'

    describe 'names' ->
      # [@valid-parent-name!, @name].compact!
      specify 'is [kris]' ->
        expect(helper.full-name!).to.eql ['kris']

    describe 'parent-name' ->
      # @pipe.parent-name!
      specify 'is void' ->
        expect(helper.parent-name!).to.eql void
