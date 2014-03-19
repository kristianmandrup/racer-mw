/**
 * User: kmandrup
 * Date: 15/03/14
 * Time: 21:38


          * name: 'Emy'
            email: 'emy@gmail.com'
 */
requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

Parser          = requires.pipe   'parser'

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

  describe 'parse-str' ->
    specify 'parsed into an Attribute pipe' ->
      expect(parser.parse-str 'name').to.be.an.instance-of AttributePipe

  describe 'parse-array' ->
    specify 'string not parsed' ->
      expect(-> parser.parse-array 'name').to.throw

    specify 'string not parsed without key' ->
      expect(-> parser.parse-array ['x', 'y']).to.throw

    specify 'parsed into an Attribute pipe' ->
      expect(parser.parse-array 'names', ['x', 'y']).to.be.an.instance-of AttributePipe

  describe 'parse-collection' ->
    specify 'string not parsed' ->
      expect(-> parser.parse-collection 'name').to.throw

    specify 'string not parsed without key' ->
      expect(-> parser.parse-collection ['x', 'y']).to.throw

    specify 'parsed into an Attribute pipe' ->
      expect(parser.parse-collection 'users', [{name: 'kris'}]).to.be.an.instance-of CollectionPipe

  describe 'list-type' ->
    specify 'empty list: empty' ->
      expect(parser.list-type('x')).to.eql 'empty'

    specify 'empty list: empty' ->
      expect(parser.list-type('x', [])).to.eql 'empty'

    specify 'obj list: collection' ->
      expect(parser.list-type('x', [{x: 1}])).to.eql 'collection'

    specify 'primitive list: array' ->
      expect(parser.list-type('x', [1,2,3])).to.eql 'array'

    specify 'mixed list: mixed' ->
      expect(parser.list-type('x', [1,2,{x: 3}])).to.eql 'mixed'

  describe 'parse-plural' ->
    specify 'empty list: fails' ->
      expect(-> parser.parse-plural('x', [])).to.throw

    specify 'mixed list: mixed' ->
      expect(-> parser.parse-plural('x', [1,2,{x: 3}])).to.throw

    specify 'obj list: collection' ->
      expect(parser.parse-plural('x', [{x: 1}])).to.be.an.instance-of CollectionPipe

    specify 'primitive list: array' ->
      expect(parser.parse-plural('x', [1,2,3])).to.be.an.instance-of AttributePipe

  describe 'tupel-type' ->
    specify 'no arg: fails' ->
      expect(-> parser.tupel-type!).to.throw

    specify 'number: fails' ->
      expect(-> parser.tupel-type 3).to.throw

    specify '_users: path' ->
      expect(parser.tupel-type '_users').to.eql 'path'

    specify '$users: path' ->
      expect(parser.tupel-type '$users').to.eql 'path'

    specify 'users: plural' ->
      expect(parser.tupel-type 'users').to.eql 'plural'

    specify 'user: single' ->
      expect(parser.tupel-type 'user').to.eql 'single'

    specify 'xyz: fails' ->
      expect(-> parser.tupel-type 'xyz').to.throw

  describe 'build-model' ->
    specify 'user: void - ok' ->
      expect(parser.build-model 'user', void).to.be.an.instance-of ModelPipe

  describe 'build-collection' ->
    specify 'users: void - ok' ->
      expect(parser.build-collection 'users', void).to.be.an.instance-of CollectionPipe


  describe 'parse-tupel' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-tupel!).to.throw

    specify 'number: fails' ->
      expect(-> parser.parse-tupel 3).to.throw

    specify '_users: path' ->
      expect(parser.parse-tupel '_users').to.be.an.instance-of PathPipe

    specify '$users: path' ->
      expect(parser.parse-tupel '$users').to.be.an.instance-of PathPipe

    specify 'users: plural' ->
      expect(parser.parse-tupel 'users').to.be.an.instance-of CollectionPipe

    specify 'user: single' ->
      expect(parser.parse-tupel 'user').to.be.an.instance-of ModelPipe

    specify 'xyz: fails' ->
      expect(-> parser.parse-tupel 'xyz').to.throw

  describe 'parse-object' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-object!).to.throw

    specify 'number: fails' ->
      expect(-> parser.parse-object 3).to.throw

    specify 'string: fails' ->
      expect(-> parser.parse-object 'x').to.throw

    specify 'admin: object - ok' ->
      expect(parser.parse-object(admin: {name: 'kris'})).to.be.an.instance-of ModelPipe

    specify 'admin: objects - ok' ->
      expect(parser.parse-object(admin: {name: 'kris'}, guest: {name: 'unknown'} ).last!).to.be.an.instance-of ModelPipe

  describe 'parse-single' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-single!).to.throw

    specify 'one arg: fails' ->
      expect(-> parser.parse-single 'x').to.throw

    specify 'one arg: user - ok' ->
      expect(-> parser.parse-single 'user').to.not.throw

    describe 'admin: object - ok' ->
      before ->
        result := parser.parse-single 'admin', {name: 'kris'}

      specify 'returns model pipe' ->
        expect(result).to.be.an.instance-of ModelPipe

      specify 'value is name: kris' ->
        expect(result.value-obj.value).to.eql name: 'kris'

  describe 'parse-path' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-path!).to.throw

    specify '_page: PathPipe' ->
      expect(parser.parse-path '_page').to.be.an.instance-of PathPipe

    specify '_page: x - fails' ->
      expect(-> parser.parse-path '_page', 'x').to.throw

    specify '_page: object - ok' ->
      expect(parser.parse-path '_page', {x: 1}).to.be.an.instance-of PathPipe

  describe 'parse-obj' ->
    specify 'no arg: fails' ->
      expect(-> parser.parse-obj!).to.throw

    specify 'number: fails' ->
      expect(-> parser.parse-obj 3).to.throw

    specify 'string: ok' ->
      expect(parser.parse-obj 'x').to.be.an.instance-of AttributePipe

    specify 'name: kris - ok' ->
      expect(parser.parse-obj name: 'kris').to.be.an.instance-of AttributePipe

    specify 'userCount: 2 - ok' ->
      expect(parser.parse-obj userCount: 2).to.be.an.instance-of AttributePipe

    specify 'array of strings ok' ->
      expect(parser.parse-obj(['name', 'email']).first!).to.be.an.instance-of AttributePipe

    specify 'array of objects ok' ->
      expect(parser.parse-obj([{name: 'kris'}]).first!).to.be.an.instance-of AttributePipe

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