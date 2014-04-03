get     = require '../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

PathPipe                = get.apipe 'path'
AttributePipe           = get.apipe 'attribute'
AttributePipeBuilder    = get.attribute-builder 'attribute'

describe 'AttributePipeBuilder' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take an object that can attach' ->
        expect(-> new AttributePipeBuilder).to.throw

  context 'Path pipe' ->
    before ->
      pipe := new PathPipe '_path'

    describe 'init' ->
      specify 'pass pipe - success' ->
        expect(-> new AttributePipeBuilder pipe).to.not.throw

    describe 'create AttributePipe' ->
      expect(new AttributePipe 'email').to.be.an.instance-of AttributePipe

    describe 'build' ->
      expect(-> new AttributePipeBuilder(pipe).build 'name').to.not.throw

    describe 'attribute' ->
      var attr

      context 'a name attribute' ->
        before ->
          builder = new AttributePipeBuilder pipe
          attr := builder.build 'name'

        describe 'model to add project model attribute' ->
          specify 'is a project model' ->
            expect(attr).to.be.an.instance-of AttributePipe

          specify 'adds project model as project child of user model ' ->
            expect(attr.name).to.eq 'name'