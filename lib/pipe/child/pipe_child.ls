# Family method to access parent etc.

PipeChild = new Module(
  has-parent: ->
    @parent isnt void
  no-parent: ->
    not @has-parent!

  has-ancestors: ->
    not @no-ancestors!
  no-ancestors: ->
    lo.is-empty @ancestors!

  ancestors: ->
    my-ancestors = []
    if @parent
      my-ancestors.push @parent
      my-ancestors.push @parent.ancestors! if @parent.ancestors
    my-ancestors.flatten!.compact!
)

module.exports = PipeChild