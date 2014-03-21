requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeNavigator   = requires.pipe   'pipe_navigator'
ModelPipe       = requires.apipe  'model'
CollectionPipe  = requires.apipe  'collection'

describe 'PipeNavigator' ->
  var pipe, obj, nav

  pipes = {}

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new PipeNavigator).to.throw

  context 'model pipe' ->
    before ->
      pipes.model := new ModelPipe user: {_clazz: 'user'}

    specify 'PipeNavigator can be created' ->
      expect(-> new PipeNavigator pipes.model).to.not.throw

    context 'PipeNavigator for model pipe' ->
      before ->
        nav  := new PipeNavigator pipes.model

      specify 'has pipe' ->
        expect(nav.pipe).to.eq pipes.model

      describe 'root' ->
        specify 'is self' ->
          expect(nav.root!).to.eq pipes.model

      describe 'prev' ->
        specify 'is self' ->
          expect(nav.prev!).to.eq pipes.model

    context 'for model pipe in collection' ->
      before ->
        pipes.modl = new CollectionPipe('users').model('user')
        pipes.col := pipes.modl.parent
        nav  := new PipeNavigator pipes.modl

      specify 'has pipe' ->
        expect(nav.pipe).to.eq pipes.modl

      describe 'root' ->
        specify 'is collection pipe' ->
          expect(nav.root!).to.eq pipes.col

      describe 'prev' ->
        specify 'is collection pipe' ->
          expect(nav.prev!).to.eq pipes.col


  context.only 'for attribute pipe in model, collection' ->
    before ->
      pipes.modl = new CollectionPipe('users').model('user')
      pipes.attr = pipes.modl.attribute('name')
      pipes.col  = pipes.modl.parent
      nav  := new PipeNavigator pipes.attr

    specify 'has pipe' ->
      expect(nav.pipe).to.eq pipes.attr

    describe 'root' ->
      specify 'is collection pipe' ->
        expect(nav.root!).to.eq pipes.col

    describe 'prev' ->
      specify 'is modl pipe' ->
        expect(nav.prev!).to.eq pipes.modl
