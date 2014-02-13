rek         = require 'rekuire'
requires    = rek 'requires'

module.exports =
  RacerMw : requires.mw   'racer-mw'
  Crud    : requires.file 'crud'