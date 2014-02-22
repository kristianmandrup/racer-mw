requires = require '../../../../requires'

requires.test 'test_setup'

ArgStore        = requires.resource 'arg/store'

expect = require('chai').expect

errors        = requires.lib 'errors'

describe 'ArgStore' ->
  var store
  stores = {}

  describe 'init' ->
    context 'no args' ->
      specify 'creates it' ->
        expect(-> new ArgStore).to.not.throw

  describe 'repo' ->
    before ->
      store := new ArgStore

    specify 'returns full store' ->
      expect(store.repo).to.not.be.empty

    specify 'store push command is not empty' ->
      expect(store.repo['push']).to.not.be.empty
