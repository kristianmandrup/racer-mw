require 'rekuire'
require 'requires'

crud = 
  Create: requires.crud 'create'
  
describe crud.Create ->
  creators = {}
  
  before ->
    creators.basic = new crud.Create
    
  describe 'created instance' ->
    specify 'has middleware stack' ->
      expect(creators.basic.mw-stack!.constructor).to.eql Middleware
