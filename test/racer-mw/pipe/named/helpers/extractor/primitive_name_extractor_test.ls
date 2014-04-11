get     = require '../../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

PrimitiveNameExtractor = get.named-extractor 'primitive_name'
# BasePipe  = get.apipe 'base'

Class = require('jsclass/src/core').Class

ArgPipe = new Class(
  initialize: (...@args) ->

  type: 'Pipe'
  info:
    type: 'ArgPipe'

  set-name: (@name) ->
    @
)

describe 'PrimitiveNameExtractor' ->
  var pipe, res

  create-extractor = (...args) ->
    pipe := new ArgPipe args
    new PrimitiveNameExtractor pipe

  describe 'instance' ->
    specify 'no args - fails' ->
      expect(-> create-extractor!.extract-and-set!).to.throw Error

    specify 'Object arg - fails' ->
      expect(-> create-extractor x: 2 .extract-and-set!).to.throw Error

    context 'String arg' ->
      specify 'creates extractor' ->
        expect(create-extractor 'x').to.be.an.instance-of PrimitiveNameExtractor

      describe 'extract-and-set' ->
        before ->
          res := create-extractor 'x' .extract-and-set!

        specify 'returns pipe' ->
          expect(res).to.eq pipe

        specify 'pipe name is set' ->
          expect(res.name).to.eql 'x'
