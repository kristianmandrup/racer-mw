requires = require '../../../../requires'

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

  create-parser = (options) ->
    new PipeParser options

  before ->
    parser  := create-parser!

  describe 'parse-collection' ->
    specify 'parsed into a Collection pipe' ->
      expect(parser.parse-collection 'users', [{name: 'kris'}]).to.be.an.instance-of CollectionPipe

  describe 'parse-plural' ->
    specify 'obj list: collection' ->
      expect(parser.parse-plural('x', [{x: 1}])).to.be.an.instance-of CollectionPipe

  describe 'build-collection' ->
    specify 'users: void - ok' ->
      expect(parser.build-collection 'users', void).to.be.an.instance-of CollectionPipe

  describe 'parse-tupel' ->
    specify 'users: plural' ->
      expect(parser.parse-tupel 'users').to.be.an.instance-of CollectionPipe

  context 'parse CollectionPipe users' ->
    var users, obj, fchild

    before ->
      obj :=
        users:
          * name: 'kris'
            email: 'kris@the.man'
          ...

      parser  := create-parser
      # parser.debug!

      users         := parser.parse obj
      console.log obj
      console.log 'USERS', users.describe true
      child := users.first!
      # console.log 'CHILD', child

    specify 'has one child' ->
      expect(users.child-list!.length).to.equal 1

    context 'child' ->
      specify 'is user model: kris' ->
        expect(child).is.an.instance-of ModelPipe

      specify 'has value: kris' ->
        expect(child.value!).to.equal {name: 'kris', email: 'kris@the.man'}

  context 'collection of users' ->
    before ->
      objs.users  :=
        users:
          * name: 'Kris'
            email: 'kmandrup@gmail.com'
          ...
      parser  := create-parser!
      parser.debug!
      result := parser.parse objs.users
      console.log 'RESULT', result.describe true

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