

describe 'TupleTypeDetector' ->
  var tuple-parser

  describe 'validate-setter(msg)' ->
    # unless typeof! @value is 'Array'
      # throw new Error "#{msg} must be an Array, was: #{typeof! @value} #{util.inspect @value}"
    context 'no value' ->
      before ->
        tuple-parser := create-tuple-parser 'z'

      specify 'throws' ->
        expect(-> tuple-parser.validate-array!).to.throw Error

    context 'Object value: {}' ->
      before ->
        tuple-parser := create-tuple-parser 'x', {}

      specify 'throws' ->
        expect(-> tuple-parser.validate-array!).to.throw Error

    context 'String value: y' ->
      before ->
        tuple-parser := create-tuple-parser 'x', 'y'

      specify 'throws' ->
        expect(-> tuple-parser.validate-array!).to.throw Error

    context 'Array value: []' ->
      before ->
        tuple-parser := create-tuple-parser 'x', []

      specify 'throws' ->
        expect(-> tuple-parser.validate-array!).to.not.throw Error