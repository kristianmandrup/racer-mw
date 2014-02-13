require 'rekuire'
require 'requires'

crud = 
  Set: requires.crud 'set'
  
describe crud.Set ->
  setters = {}
  
  before ->
    setters.basic = new crud.Set
    
  describe 'created instance' ->
    specify 'has middleware stack' ->
      expect(setters.basic.mw-stack!.constructor).to.eql Middleware
