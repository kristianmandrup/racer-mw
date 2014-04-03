get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ModelPipe       = get.apipe 'model'
AttributePipe   = get.apipe 'attribute'

describe 'ModelPipe' ->
  describe 'parse' ->
    context 'user Model - one object' ->
      var model-pipe, obj

      before ->
        model-pipe := new ModelPipe 'user'
        obj :=
          name: 'kris'
          email: 'kris@gmail.com'

        model-pipe.parse obj
        # console.log model-pipe.describe!


      specify 'parses name pipe' ->
        expect(model-pipe.child 'name').to.be.an.instance-of AttributePipe

      specify 'parses email pipe' ->
        expect(model-pipe.child 'email').to.be.an.instance-of AttributePipe
