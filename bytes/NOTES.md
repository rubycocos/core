# Notes on Bits 'n' Bytes






##   Buffer classes in ruby

open naming questions?

use Buffer as an alias for
Bytes | ByteArray or StringBuffer ?

or use Bytes for immutable ByteArrays and Buffer for mutable ByteArrays ????



### StringIO
StringIO is really like a StringBuffer with file-like read/write access


### IO::Buffer

see <https://ruby-doc.org/core-3.1.2/IO/Buffer.html>


###  More

arraybuffer gem
- <https://rubygems.org/gems/arraybuffer>
- <https://github.com/andrepiske/rb-arraybuffer>
- <https://www.reddit.com/r/ruby/comments/uffg1h/arraybuffer_and_dataview_classes_for_ruby/>

ByteBuffer in nio4r gem
- <https://rubygems.org/gems/nio4r>
- <https://github.com/socketry/nio4r>
- <https://github.com/socketry/nio4r/wiki/Byte-Buffers>
- <https://www.rubydoc.info/gems/nio4r/2.5.2/NIO/ByteBuffer>


Buffer in FFI gem
- <https://rubydoc.info/gems/ffi/FFI/Buffer>




##  In other languages

- see python  - uses string and bytes (immutable) and bytearray (mutable)
- see Buffer in node.js
