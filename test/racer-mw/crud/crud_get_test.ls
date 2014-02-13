require 'rekuire'
require 'requires'

crud = 
  Get: requires.crud 'get'
  
describe crud.Get ->
  getters = {}
  
  before ->
    getters.basic = new crud.Get
    
  describe 'created instance' ->
    specify 'has middleware stack' ->
      expect(getters.basic.mw-stack!.constructor).to.eql Middleware
