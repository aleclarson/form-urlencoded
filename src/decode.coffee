
isObject = require "isObject"

bracketRE = /[^\[\]]+/g

module.exports = (str) ->
  values = {}
  pairs = str.split "&"
  for pair in pairs
    pair = pair.split "="
    key = decodeURIComponent pair[0]
    value = decodeURIComponent pair[1]

    if ~key.indexOf "["
    then setValue values, parseKeys(key), value
    else values[key] = value
  return values

#
# Helpers
#

parseKeys = (key) ->
  keys = []
  bracketRE.lastIndex = 0
  while match = bracketRE.exec key
    keys.push match[0]
  return keys

setValue = (values, keys, value) ->
  parent = values

  index = -1
  lastIndex = keys.length - 1
  while ++index < lastIndex
    key = keys[index]
    parent = (ancestor = parent)[key]

    if 0 <= Number keys[index + 1]
      unless Array.isArray parent
        ancestor[key] = parent = []

    else unless isObject parent
      ancestor[key] = parent = {}

  parent[keys[index]] = value
  return
