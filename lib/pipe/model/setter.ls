ModelSetter = new Module(
  set: (obj) ->
    @set-class obj
    @set-name extract.name(obj, @clazz)
    @set-value extract.value(obj)

  set-class: (obj) ->
    @clazz = extract.clazz(obj)

  # don't use extract.value here!!
  set-value: (obj) ->
    @call-super obj
)

module.exports = ModelSetter