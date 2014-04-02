require './test_setup'
expect = require('chai').expect

requires  = require '../requires'
PathMaker = require '../path_maker'

describe 'Requires' ->
  var pipe, pipe-a, pipe-b

  describe 'lib file' ->
    specify 'requires it' ->
      expect(requires.lib 'errors').to.not.be.undefined

  describe 'Folder' ->
    specify 'lib is a Folder' ->
      expect(requires.lib!).to.have.a.property 'pipe'

  describe 'lib pipe' ->
    specify 'pipe is a PathMaker' ->
      expect(requires.lib!.pipe).to.be.an.instance-of PathMaker

  specify 'pipe is a PathMaker' ->
    expect(requires.pipe!).to.be.an.instance-of PathMaker

    context 'PathMaker instance' ->
      before ->
        pipe-a := requires.lib!.pipe.disable 'auto-resolve'
        pipe-b := requires.lib!.pipe.disable 'auto-resolve'

      specify 'ChildPipe - required' ->
        expect(pipe-a.named 'child').to.eql "./lib/pipe/child_pipe"

      specify 'Base - required' ->
        expect(pipe-b.apipe 'base').to.eql "./lib/pipe/base/base_pipe"

