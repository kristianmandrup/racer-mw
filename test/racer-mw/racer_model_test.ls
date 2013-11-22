require '../test_setup'

RacerModel = require '../../racer_model'

describe 'Permit init - no args', ->
  model = null

  before ->
    model := RacerModel()

  specify 'creates a model', ->
    model.should.have.property('getAll')