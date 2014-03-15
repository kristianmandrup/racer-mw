/**
 * User: kmandrup
 * Date: 15/03/14
 * Time: 18:02
 */
requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

CollectionPipe  = requires.apipe 'collection'
ModelPipe       = requires.apipe 'model'
PathPipe        = requires.apipe 'path'

require 'sugar'

Dsl = requires.pipe 'dsl'

describe 'Dsl' ->
  describe 'collection' ->
    specify 'creates CollectionPipe' ->
      expect(Dsl.collection 'users').to.be.an.instance-of CollectionPipe

  describe 'path' ->
    specify 'creates PathPipe' ->
      expect(Dsl.path '_page').to.be.an.instance-of PathPipe

  describe 'model' ->
    specify 'creates ModelPipe' ->
      expect(Dsl.model(user: name: 'Kris')).to.be.an.instance-of ModelPipe

  describe 'attribute' ->
    specify 'fails' ->
      expect(-> Dsl.attribute(name: 'Kris')).to.throw