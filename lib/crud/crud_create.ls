Class       = require('jsclass/src/core').Class
Module      = require('jsclass/src/core').Module
Hash        = require('jsclass/src/core').Hash

rek         = require 'rekuire'
requires    = rek 'requires'
lo          = require 'lodash'
_           = require 'prelude-ls'

# RacerSync   = requires.crud 'racer_sync'
CrudSet     = requires.crud 'crud_create'

_ = require 'prelude-ls'

module.exports = new Class(CrudSet,

  # authorize, Create
  # validate model
  one: (model)->
    @perform 'createModel', model
)