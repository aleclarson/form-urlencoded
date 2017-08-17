
isObject = require "isObject"

# Reuse one array for all encoding.
pairs = []

module.exports = (values) ->

  for key of values
    encodePair key, values[key]

  str = pairs.join "&"
  pairs.length = 0
  return str

#
# Helpers
#

encodePair = (key, value) ->
  return if value is undefined

  if isObject value
    encodeObject value, key
    return

  if Array.isArray value
    encodeArray value, key
    return

  pairs.push encodeURIComponent(key) + "=" + encodeURIComponent(value)
  return

encodeObject = (values, parent) ->
  for key of values
    encodePair parent + "[" + key + "]", values[key]
  return

encodeArray = (values, parent) ->
  index = -1
  while ++index < values.length
    encodePair parent + "[" + index + "]", values[index]
  return
