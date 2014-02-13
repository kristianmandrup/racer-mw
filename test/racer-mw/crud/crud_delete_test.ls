require 'rekuire'
require 'requires'

crud = 
  Delete: requires.crud 'delete'
  
describe crud.Delete ->
  deletors = {}
  
  before ->
    deletors.basic = new crud.Delete
    
  describe 'created instance' ->
    specify 'has middleware stack' ->
      expect(deletors.basic.mw-stack!.constructor).to.eql Middleware
