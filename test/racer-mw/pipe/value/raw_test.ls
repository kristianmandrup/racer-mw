describe 'Raw stuff' ->
  var obj, parser, rawContained, raw
  describe 'raw-value ' ->
    context 'model with two attributes' ->
      var model
      before ->
        obj :=
          admin:
            name: 'kris'
            email: 'kris@the.man'

        parser  := new Parser obj
        # parser.debug!

        model         := parser.parse!
        raw-contained := model.raw-value true
        raw           := model.raw-value!

      specify 'model is a ModelPipe' ->
        expect(model).to.be.an.instance-of ModelPipe

      specify 'name is an AttributePipe' ->
        expect(model.child 'name').to.be.an.instance-of AttributePipe

      specify 'gets raw contained value from attributes' ->
        expect(raw-contained ).to.eql obj

      specify 'gets raw value from attributes' ->
        expect(raw).to.eql {name: 'kris', email: 'kris@the.man'}

      describe 'on child update' ->
        specify 'parent sets new computed value' ->
          child = model.child('name')

          model.on-child-update child, 'emma'
          expect(model.value!).to.eql {name: 'emma', email: 'kris@the.man'}

      specify 'notify parent on child value change' ->
        model.child('name').set-value 'emma'
        expect(model.value!).to.eql {name: 'emma', email: 'kris@the.man'}

  describe 'raw-value ' ->
    context 'collection with one model' ->
      var users
      before ->
        obj :=
          users:
            * name: 'kris'
              email: 'kris@the.man'
            ...

        parser  := new Parser obj
        # parser.debug!

        users         := parser.parse!
        raw-contained := users.raw-value true
        raw           := users.raw-value!

      specify 'model is a ModelPipe' ->
        expect(users).to.be.an.instance-of CollectionPipe

      specify 'name is an AttributePipe' ->
        expect(users.child '0').to.be.an.instance-of ModelPipe

      specify 'gets raw value from attributes' ->
        expect(raw).to.eql {0: {name: 'kris', email: 'kris@the.man'} }

      specify 'gets raw contained value from attributes' ->
        expect(raw-contained).to.eql users: {0: {name: 'kris', email: 'kris@the.man'} }