#  Hex(adecimal) Encode / Decode Helpers - From Hex(adecimal) String to Bin(ary) String And Back

hexutils - hex(adecimal) encode/decode helpers 'n' more for String, NilClass, Kernel and more


* home  :: [github.com/rubycocos/core](https://github.com/rubycocos/core)
* bugs  :: [github.com/rubycocos/core/issues](https://github.com/rubycocos/core/issues)
* gem   :: [rubygems.org/gems/hexutils](https://rubygems.org/gems/hexutils)
* rdoc  :: [rubydoc.info/gems/hexutils](http://rubydoc.info/gems/hexutils)



Part of the [**If I Were ~~King~~ Matz (aka Yukihiro Matsumoto) - Ideas For Ruby 4.0   - What's Broken & Missing in Ruby 3.x and How To Fix It**](https://github.com/rubycocos/core#if-i-were-king-matz-aka-yukihiro-matsumoto---ideas-for-ruby-40-----whats-broken--missing-in-ruby-3x-and-how-to-fix-it)
Series



## Usage


For some background on working with bin(ary) and hex(adecimal)
strings in ruby
see  the [**Programming Bits, Bytes 'n' Blocks Step-by-Step Book / Guide**](https://github.com/rubycocos/core/tree/master/bytes#background----programming-bits-bytes-n-blocks-step-by-step-book--guide)
Let's start with the three types of strings, that is, bytes, string buffers, and frozen strings, ...



To make programming hex(adecimal) strings easier
let's add some encode / decode helpers.


### New in `Kernel` Module  - `decode_hex` (or `hex`) and `encode_hex`

``` ruby
require 'hexutils'

# get a bin(ary) string from a hex(adecimal) string
hex '0xffff'     # or
hex( '0xffff' )  # or
decode_hex( '0xffff' )
#=> "\xff\xff".b

# get a hex(a)decimal string from a bin(ary) string
encode_hex( "\xff\xff".b )
#=> "ffff"
```

Note:  The  `decode_hex` (or `hex`) helper
allows all variants of upper- and lowercase
with or without the `0x`/`0X` prefix
e.g. `0XFFFF`, `FFFF`, `ffff`, etc.
For convenience whitespace incl.
newlines are allowed anywhere.



###  New in `String` Class  - `to_hex` (or `hex`) and `hex?` (or `is_hex?`)

``` ruby
# get a hex(a)decimal string from a bin(ary) string
"\xff\xff".b.hex   # or
"\xff\xff".b.to_hex   # or
#=> "ffff"

"\xff\xff".b.hex?  # or
"\xff\xff".b.is_hex?
#=> false

"ffff".hex?      # or
"ffff".is_hex?   # or
"0xffff".is_hex?   # or
"0XFFFF".is_hex?   # or
#=> true
```


NOTE:  The "old" `String#hex` method that returns an integer number
from a hex(adecimal) string gets rewired or is that "monkey patched"
to  `String#old_hex` and `String#hexnum`.



### Bonus: New in  `NilClass` Class - `to_hex` (or `hex`) and `hex?` (or `is_hex?`)

``` ruby
nil.hex?  # or
nil.is_hex?
#=> false

nil.hex   # or
nil.to_hex
#=> ''
```



That's it for now.



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.




## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!

