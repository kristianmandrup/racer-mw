module.exports =
  Getter:
    get-one: ->
      @res.get!

    get-all: ->
      @res.fetch (err) ->
        throw Error "Error: Get.one #{err}" if err
        items.get!