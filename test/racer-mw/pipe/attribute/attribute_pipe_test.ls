get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

AttributePipe  = get.apipe 'attribute'

describe 'AttributePipe' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new AttributePipe).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new AttributePipe obj).to.throw

    context 'arg: object with _clazz' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'fails' ->
        expect(-> new AttributePipe obj).to.throw

    context 'arg: string' ->
      specify 'creates it' ->
        expect(new AttributePipe 'email').to.be.an.instance-of AttributePipe

      specify 'sets name to users' ->
        expect(new AttributePipe('email').name).to.eq 'email'

    context 'arg: function' ->
      specify 'creates it' ->
        expect(-> new AttributePipe (-> 'email')).to.not.throw

      specify 'creates it' ->
        expect(new AttributePipe 'email').to.be.an.instance-of AttributePipe

    # Does this make sense ???
    context 'arg: array' ->
      specify 'creates it' ->
        expect(-> new AttributePipe '_page', 'status').to.not.throw

      specify 'creates it' ->
        expect(new AttributePipe '_page', 'status').to.be.an.instance-of AttributePipe

    context 'arg: number' ->
      specify 'creates it only if child of collection - fails here' ->
        expect(-> new AttributePipe 1).to.throw Error

  context 'Pipe: parentless users' ->
    before ->
      pipe := new AttributePipe 'status'

    describe 'children' ->
      specify 'none' ->
        expect(pipe.children).to.be.empty

    describe 'parent' ->
      specify 'is void' ->
        expect(pipe.parent).to.be.undefined
