require 'rekuire'
require 'requires'

crud = 
  Edit: requires.crud 'edit'
  
describe crud.Edit ->
  editors = {}
  
  before ->
    editors.basic = new crud.Edit
    
  describe 'created instance' ->
    specify 'has middleware stack' ->
      expect(editors.basic.mw-stack!.constructor).to.eql Middleware
