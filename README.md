
# form-urlencoded v1.0.0

Encodes an object (or decodes a string) using `x-www-form-urlencoded` rules.

```coffee
formUrlEncoded = require "form-urlencoded"
```

### Encoding an object

```coffee
string = formUrlEncoded {}
```

- Undefined values are ignored.
- Empty arrays/objects are ignored.
- Nested object keys are formatted like `a[b][c]=1`
- Nested arrays are formatted like `a[0]=2`
- Keys and values are encoded with `encodeURIComponent`

### Decoding a string

```coffee
obj = formUrlEncoded ''
```
