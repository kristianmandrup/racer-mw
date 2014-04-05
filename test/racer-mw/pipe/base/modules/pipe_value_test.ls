Class  = require('jsclass/src/core').Class
get = require '../../../../../requires' .get!
get.test 'test_setup'
expect = require('chai').expect
require 'sugar'

PipeValue       = get.base-module  'value'
ValueObject     = get.value-object 'base'

PipeWithValue = new Class(
  include: PipeValue

  initialize: ->
    @call-super!
    @
)

clazz-name = (name) ->
  "Pipe#{name.camelize!}"

# Parser          = get.pipe-parser   'pipe_parser'
pipes = {}
<[model collection attribute path]>.each (name) ->
  pipes[clazz-name name] = get.apipe name

describe 'PipeValue' ->
  var pipe, obj, result, raw, raw-contained, parser, users

  context 'pipe with value' ->
    before ->
      pipe := new PipeWithValue

    describe 'set-value' ->
      before ->
        result := pipe.set-value 'x'

      specify 'result is value that was set' ->
        expect(result).to.eq 'x'

      context 'set value to x' ->
        before ->
          pipe.set-value 'x'

        specify 'value-obj is a ValueObject' ->
          expect(pipe.value-obj).to.be.an.instance-of ValueObject

        specify 'value-obj.value is x' ->
          expect(pipe.value-obj.value).to.eql 'x'

        specify 'value! is x' ->
          expect(pipe.value!).to.eql 'x'

  context 'users' ->
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
      console.log users.describe true

    describe 'on child update' ->
      before ->
        child = users.get 0
        users.on-child-update child, {name: 'mike', email: 'mike@the.man'}

      specify 'parent does not set new computed value' ->
        expect(users.value!).to.eql { 0: {name: 'kris', email: 'kris@the.man'} }

    describe 'set value' ->
      var res
      before ->
        console.log users.describe!
        child = users.get 0
        res := child.set-value {name: 'mike', email: 'mike@the.man'}
        console.log 'RES', res

      specify.only 'notify parent on child value change' ->
        expect(users.value!).to.eql { 0: {name: 'mike', email: 'mike@the.man'} }