requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

Parser          = requires.pipe   'pipe_parser'

ModelPipe       = requires.apipe   'model'
CollectionPipe  = requires.apipe   'collection'
AttributePipe   = requires.apipe   'attribute'
PathPipe        = requires.apipe   'path'

util = require 'util'

describe 'Parser' ->
  var parser, obj, result, child, children

  objs    = {}
  attrs   = {}

  before ->
    parser  := new Parser

  describe 'parse-obj' ->
    describe 'mixed array of objects + strings ok' ->
      before ->
        result := parser.parse-obj(['email', admin-user: {name: 'kris'}])

      specify 'first is AttributePipe' ->
        expect(result.first!).to.be.an.instance-of AttributePipe

      specify 'last is ModelPipe' ->
        expect(result.last!).to.be.an.instance-of ModelPipe

  describe 'parse' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse!).to.throw

    context 'collection of users' ->
      before ->
        objs.users  :=
          users:
            * name: 'Kris'
              email: 'kmandrup@gmail.com'
            ...
        parser  := new Parser objs.users
        parser.debug!
        result := parser.parse!
        # console.log 'RESULT', result.describe true

      specify 'is parsed as Collection' ->
        expect(result).to.be.an.instance-of CollectionPipe

      specify 'has one child' ->
        expect(result.child-count).to.eq 1

      context 'child' ->
        before ->
          child     := result.child-list!.first!
          children  := child.child-hash
          # console.log 'CHILD', child.describe true
          # console.log 'CHILDREN', child.describe-children!

        specify 'is a ModelPipe' ->
          expect(child).to.be.an.instance-of ModelPipe

        specify 'has 2 children' ->
          expect(child.child-count).to.eq 2

        context 'name:' ->
          before ->
            attrs.name := children['name']

          specify 'is an Attribute' ->
            expect(attrs.name).to.be.an.instance-of AttributePipe

          specify 'has 0 children' ->
            expect(attrs.name.child-count).to.eq 0

        context 'email:' ->
          before ->
            attrs.email := children['email']

          specify 'email child is an Attribute' ->
            expect(attrs.email).to.be.an.instance-of AttributePipe

    context 'page w 2 attributes' ->
      before ->
        objs.page    :=
          _page:
            user-count: 2
            status: 'loading'

        parser  := new Parser objs.page
        result := parser.parse!

      specify 'is parsed as Path' ->
        expect(result).to.be.an.instance-of PathPipe

    context 'model w 2 model attributes' ->
      before ->
        objs.page    :=
          guest:
            uncle:
              name: 'mike'
            mother:
              name: 'ursula'

        parser  := new Parser objs.page
        result := parser.parse!

      specify 'is parsed as Model' ->
        expect(result).to.be.an.instance-of ModelPipe

      specify 'is parsed' ->
        expect(result).to.be.an.instance-of ModelPipe

  context 'ModelPipe' ->
    var model-pipe, obj

    before ->
      model-pipe := new ModelPipe 'user'
      obj :=
        name: 'kris'
        email: 'kris@gmail.com'

      model-pipe.parse obj
      # console.log model-pipe.describe!

    describe 'parse' ->
      specify 'parses name pipe' ->
        expect(model-pipe.child 'name').to.be.an.instance-of AttributePipe

      specify 'parses email pipe' ->
        expect(model-pipe.child 'email').to.be.an.instance-of AttributePipe

  context 'ModelPipe' ->
    var users, obj, fchild

    before ->
      obj :=
        users:
          * name: 'kris'
            email: 'kris@the.man'
          ...

      parser  := new Parser obj
      # parser.debug!

      users         := parser.parse!
      console.log obj
      console.log 'USERS', users.describe true
      child := users.first!
      console.log 'CHILD', child

    specify 'has one child' ->
      expect(users.child-list!.length).to.equal 1

    context 'child' ->
      specify 'is user model: kris' ->
        expect(child).is.an.instance-of ModelPipe

      specify 'has value: kris' ->
        expect(child.value!).to.equal {name: 'kris', email: 'kris@the.man'}