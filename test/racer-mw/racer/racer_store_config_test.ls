requires = require '../../../requires'

requires.test 'test_setup'
require 'sugar'

store-config    = requires.racer 'racer_store_config'

expect          = require('chai').expect

describe 'Racer StoreConfig' ->
  describe 'racer-store' ->
    specify 'connects to mongo and redis :)' ->
      expect(store-config.racer-store!).to.not.be.undefined
