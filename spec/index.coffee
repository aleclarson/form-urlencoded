
formUrlEncoded = require ".."

describe "encoding", ->

  it "ignores undefined values", ->
    s = formUrlEncoded {a: undefined, b: 2}
    expect(s).toBe 'b=2'

  it "ignores empty objects", ->
    s = formUrlEncoded {a: {}, b: 2}
    expect(s).toBe 'b=2'

  it "ignores empty arrays", ->
    s = formUrlEncoded {a: [], b: 2}
    expect(s).toBe 'b=2'

  it "supports nested objects", ->
    s = formUrlEncoded {a: {b: 1, c: {d: 2}}}
    expect(decodeURIComponent s).toBe 'a[b]=1&a[c][d]=2'

  it "supports nested arrays", ->
    s = formUrlEncoded {a: [1, 2]}
    expect(decodeURIComponent s).toBe 'a[0]=1&a[1]=2'

  it "supports objects nested in arrays", ->
    s = formUrlEncoded {a: [{ b: 1 }]}
    expect(decodeURIComponent s).toBe 'a[0][b]=1'

  it "supports arrays nested in arrays", ->
    s = formUrlEncoded {a: [[1], 2]}
    expect(decodeURIComponent s).toBe 'a[0][0]=1&a[1]=2'

describe "decoding", ->

  it "supports key-value pairs", ->
    o = formUrlEncoded 'a=1&b=2'
    expect(o).toEqual {a: '1', b: '2'}

  it "supports nested objects", ->
    o = formUrlEncoded 'a[b]=1&a[c]=2'
    expect(o.a).toEqual {b: '1', c: '2'}

  it "creates missing ancestors", ->
    o = formUrlEncoded 'a[b][c]=1'
    expect(o.a.b).toEqual {c: '1'}

  it "supports nested arrays", ->
    o = formUrlEncoded 'a[0]=1&a[1]=2'
    expect(o.a).toEqual ['1', '2']

  it "supports objects nested in arrays", ->
    o = formUrlEncoded 'a[0][b]=1'
    expect(o.a[0].b).toBe '1'

  it "supports arrays nested in arrays", ->
    o = formUrlEncoded 'a[0][0]=1'
    expect(o.a[0]).toEqual ['1']

  it "overwrites previous values", ->
    o = formUrlEncoded 'a[b]=1&a[b]=2'
    expect(o.a.b).toBe '2'

  it "overwrites an object if another key assumes it's an array", ->
    o = formUrlEncoded 'a[b]=1&a[0]=2'
    expect(o.a).toEqual ['2']

  it "overwrites an array if another key assumes it's an object", ->
    o = formUrlEncoded 'a[0]=1&a[b]=2'
    expect(o.a).toEqual {b: '2'}
