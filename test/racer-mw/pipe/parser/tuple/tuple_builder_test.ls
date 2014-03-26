
describe 'TupleBaseParser' ->
  var parser, tuple-parser

  create-tuple-parser = (key, value) ->
    new TupleParser key, value

    describe 'build(name, key, value)' ->
      # value ||= @value; key ||= @key
      # @build name, key, value
      specify.only 'collection: users' ->
        expect(tuple-parser.build 'collection', 'users').to.not.throw Error

      specify 'model: user' ->
        expect(tuple-parser.build 'model', 'user').to.not.throw Error


  describe 'collection' ->
    # return unless @is-collection!
    # @value ||= []
    # build 'collection'
    xcontext 'value: objects' ->
      before ->
        parser := create-parser 'x', [{x: 2}, {y: 5}]

      specify 'builds attributes' ->
        expect(parser.collection!).to.be.an.instance-of CollectionPipe

    context 'value: primitives' ->
      before ->
        parser := create-parser 'x', ['a', 'b']

      specify.only 'builds attributes' ->
        expect(parser.collection!).to.be.undefined

  describe 'array' ->
    # return unless @is-array!
    # @build 'attribute'
    context 'value: objects' ->
      before ->
        parser := create-parser 'x', [{x: 2}, {y: 5}]

      specify 'builds attributes' ->
        expect(parser.array!).to.be.undefined

    xcontext 'value: primitives' ->
      before ->
        parser := create-parser 'x', ['a', 'b']

      specify 'builds attributes' ->
        expect(parser.array!.first!).to.be.an.instance-of AttributePipe

  describe 'none' ->
    # throw new Error "Unable to determine if plural: #{@key} is a collection or array, was: #{@list-type!}"
    specify 'throws' ->
      expect(-> parser.none!).to.throw Error