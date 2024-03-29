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


## More Ruby Hex Gems

### hex_string gem

- <https://github.com/atomicobject/hex_string>
- <https://rubydoc.info/gems/hex_string>


HexString provides two String extension methods: 

* `String#to_hex_string` explodes a string of binary data into human-readable hex tuples, and 
* `String#to_byte_string` converts a string of human-readable hex digits into the corresponding bytes.

**Examples**


    # Convert data to human-readable hex tuples:
    >> "hello".to_hex_string
    => "68 65 6c 6c 6f"

    # Compact a hex string into its data equivalent:
    >> "77 6f 72 6c 64".to_byte_string
    => "world"

    # (#to_byte_string is space and case-insensitive:)
    >> "776F726C64".to_byte_string
    => "world"

    # Peek at the first 4 bytes of an executable on OS X:
    >> File.read("/bin/ls")[0..3].to_hex_string
    => "ca fe ba be"

    # Omit spaces in hex string output:
    >> "hello".to_hex_string(false)
    => "68656c6c6f"


**Motivation**

When working with binary message or file formats, we often want to have a peek
at some segment of binary data and talk about individual byte values in
human-relatable terms.

This sort of thing comes in handy during testing, debugging and data
introspection, especially when it's inconvenient or impractical to capture the
desired binary data to file in order to view it with a hex editor or other
binary file reader.

We were inspired to publish this humble Gem after we found ourselves copying it
by hand from project to project over the course of several years.


### string2hex gem

- <https://github.com/kadalscript/string2hex>

Simple converter, binary string to hex string

**Usage**

```ruby
"foobar".string2hex # => "666f6f626172"

"666f6f626172".hex2string # => "foobar"
```

**Source**

```ruby
class String
  def string2hex
    self.unpack('H*').first
  end
  
  def hex2string
    [self].pack('H*')
  end
end
```

### byteman gem

- <https://rubygems.org/gems/byteman>
- <https://github.com/micahshute/byteman>

Simple gem to allow manipulation of data into other forms. Specifically, transform data between byte buffers (integer arrays with every number representing a byte ie an integer from 0-255), hexdigest strings, hex strings, and integers.

**Source**

```ruby
#...

# hex args
  # 
  # input: [Integer or String or Array] accepts any Integer, or a hexdigest String or an integer array (byte buffer) with all numbers between 0-255 inclusive
  # 
  # Returns a byte String. 
  # 
  # Note -> Automatically pads a 0 nibble to the front of any odd-lengthed hexdigest
  def self.hex(input)
    if input.is_a?(Integer)
      hex(hexdigest(input))
    elsif input.is_a?(String)
      hd = input.length.odd? ? "0#{input}" : input
      [hd].pack("H*")
    elsif input.is_a?(Array)
      input.pack("C*")
    else
      raise ArgumentError.new("Input must be a string, number, or byte array buffer")
    end
  end

  # hexdigest args
  # 
  # arg: [Integer or String or Array] accepts any Integer or String or Array of Integers from 0-255 
  # 
  # Returns a hexdigest string
  def self.hexdigest(arg)
    if arg.is_a?(Integer)
      dig = arg.to_s(16)
      dig.length.odd? ? "0#{dig}" : dig
    elsif arg.is_a?(Array) && arg.all?{|a| a.between?(0,255)}
      buf2digest(arg)
    elsif arg.is_a?(String)
      arg.unpack("H*").first
    else
      raise ArgumentError.new("Input must be an integer, Array of integers between 0-255, or String")
    end
  end

#...

```
