# Notes on Hex (Utils)



## Todos

Add base16() alias for encode_hex - why? why not?

Add a Hex.encode, Hex.decode  or Base16.encode, Base16.decode - why? why not?


about base16  see <https://www.rfc-editor.org/rfc/rfc4648#page-10>

use examples like:

```
BASE16("") = ""

BASE16("f") = "66"

BASE16("fo") = "666F"

BASE16("foo") = "666F6F"

BASE16("foob") = "666F6F62"

BASE16("fooba") = "666F6F6261"

BASE16("foobar") = "666F6F626172"
```


About error handling 
-  throw exception on error by default - why? why not?
-  or parse until hitting a non-hex char?
-  or add a strict or error option - check ruby Integer() for using the same style - why? why not?


see
node buffer ofr different handling for hex
- ignores 0x123   last "nibble" if uneven hex string (e.g. 0x12 missing 3) and NOT 0x0123
- parses until hitting a non-hex char - never fails



