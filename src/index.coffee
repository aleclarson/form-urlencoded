
encode = require "./encode"
decode = require "./decode"

module.exports = (value) ->
  if typeof value is "string"
  then decode value
  else encode value
