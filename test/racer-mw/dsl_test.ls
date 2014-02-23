# Test global DSL (main Pipe methods)

requires = require '../../requires'

# import dsl methods into this ns
requires.lib 'dsl'

describe 'RacerMW main DSL' ->
  make-project = (name) ->
    {
      name: name
      _clazz: 'project'
    }

  make-user = (name) ->
    {
      name: name
      _clazz: 'project'
    }

  var pipe
  pipes     = {}
  projects  = {}

  describe 'path (pipe)' ->
    specify 'should create a PathPipe instance' ->
      expect(create-path '_page').to.be.an.instance-of PathPipe

  describe 'collection (pipe)' ->
    specify "should create a CollectionPipe 'users' instance" ->
      expect(create-collection 'users').to.be.an.instance-of CollectionPipe

  describe 'model (pipe)' ->
    context 'project obj' ->
      before ->
        projects.my := make-project name: 'my proj'

        pipes.proj := create-model projects.my
        pipes.model := pipes.proj.children.first!

      specify "should create a CollectionPipe 'projects' instance" ->
        expect(pipe).to.be.an.instance-of CollectionPipe

      specify "the CollectionPipe 'projects' should have a child ModelPipe" ->
        expect(pipes.model).to.be.an.instance-of ModelPipe

      specify "the ModelPipe should have the value object project: my proj" ->
        expect(pipes.model.value-object).to.equal projects.my
