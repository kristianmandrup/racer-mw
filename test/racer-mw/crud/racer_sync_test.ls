require 'rekuire'
require 'requires'

Hash      = require('jsclass/src/core').Hash
RacerSync = requires.crud 'racer_sync'

describe RacerSync
  describe 'user-id' ->
    specify 'should be user: kris' ->
      expect(sync.user-id).to.eql users.kris.id
    
 
  describe 'racer-middleware' ->
    specify 'should be a Middleware' ->
      expect(sync.racer-middleware.constructor).to.eql Middleware
 
  describe 'mw-stack' ->
    specify 'should be a Hash' ->
      expect(sync.mw-stack!.constructor).to.eql Hash

    specify 'should be empty' ->
      expect(sync.mw-stack!.size).to.eql 0

  describe 'create-stack' ->
    context 'no names' ->
      specify 'no args should fail' ->
        expect( -> sync.create-stack).to.throw

      specify 'empty names list should fail' ->
        expect( -> sync.create-stack []).to.throw

    context 'no middlewares' ->
      specify 'should fail' ->
        expect( -> sync.create-stack 'blip').to.throw

    context 'middlewares exist' ->
      before ->
        middlewares := {authorize: authorize-mw}

      context 'invalid mw name' ->
        specify 'should fail' ->
          expect( -> sync.create-stack 'blip').to.throw

      context 'valid mw name' ->
        specify 'should not fail' ->
          expect( -> sync.create-stack 'authorize').to.not.throw

  describe 'item-path' ->
    context 'collection and item set' ->
      before ->
        books.kris = 
          id: 2
        # TODO: register as collection + item
      
      specify 'should return valid item path' ->
        expect(sync.item-path!).to.eql "books.#{books.kris.id}"

  describe 'perform' ->
    context 'get book' ->
      specify 'should get the requested item from the model' ->

  describe 'exec' ->
    context 'get book' ->
      specify 'should execute ...' ->

