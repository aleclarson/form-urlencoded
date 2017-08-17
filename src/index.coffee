
encode = require "./encode"
decode = require "./decode"

module.exports = (value) ->
  if typeof value is "string"
    if value
    then decode value
    else {}
  else encode value
