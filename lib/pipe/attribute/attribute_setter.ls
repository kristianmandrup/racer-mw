AttributeSetter = new Module(
  set-all: ->
    @set-name!
    @set-value!

  name-extractor: ->
    new AttributeExtractors.Name @args

  value-extractor: ->
    new AttributeExtractors.Value @args

)

module.exports = AttributeSetter