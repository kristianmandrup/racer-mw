RessourceCommand = new Class(
  # get
    # no path = self
    # path = attribute
    model:

    # no path = self
    # path = item
    collection:

    # no path = self
    # path = sub-item
    attribute:

  # set, set-null, set-diff, del
    # path = attribute
    # no path = self
    model:

    # no path = self
    # path = item
    collection:

    # no path = self
    # path = sub-item
    attribute:

  # increment
    # path = attribute
    # % no path
    model:

    # %
    collection:

    # no path = self
    # path = sub-item
    attribute:

  # add
    # path = collection attribute
    model:

    # no path = self
    # % path
    collection:

    # %
    attribute:

  # all array commands:
    # requires path
    model:

    # no path = self
    collection:

    # %
    # always a simple!
    attribute:

  # string commands
    # requires path
    model:

    # only if string
    attribute:

    # %
    collection:

  at, scope
    # requires path
    model

    # requires id
    collection:

    # %
    attribute:

  parent:
    # ok if has parent pipe
    model, collection, attribute

  path:
    # ok
    model, collection

    # %
    attribute:

  ref:
    # to = full path (or pipe)

    # path must be id
    collection
    # path is attribute
    # no path = self
    model

    # no path, is self
    attribute:

  remove-ref:
    # path must be id
    collection
    # path is attribute
    # no path = self
    model

    # no path, is self
    attribute:

  ref-list:
    # path must be self, no arg
    collection

    # path is attribute which is collection
    # % no path
    model

    # %
    attribute:

  remove-ref-list:
    # collection is a pipe collection or a full path to a collection

    # path must be self, no arg
    collection

    # path is attribute which is collection
    # % no path
    model

    # %
    attribute:

)
