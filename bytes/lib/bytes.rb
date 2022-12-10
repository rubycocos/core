require 'pp'
require 'forwardable'


## our own code
require_relative 'bytes/version'    # note: let version always go first


module BytesHelper
  def hex_to_bin( hex )
    ## todo/fix:  do an argument regex hex check!!!!
    raise TypeError, "BytesHelper.hex_to_bin - non-hexadecimal digit found in >#{hex}<" unless is_hex?( hex )

    ## note: assume pack always returns string with BINARY/ASCII-8BIT encoding!!!
    if ['0x', '0X'].include?( hex[0,2] )   ## cut-of leading 0x or 0X if present
      [hex[2..-1]].pack('H*')
    else
      [hex].pack('H*')
    end
  end
  alias_method :hex_to_bytes, :hex_to_bin
  alias_method :h_to_b,       :hex_to_bin
  alias_method :htob,         :hex_to_bin


  def bin_to_hex( bin )
    # note: unpack returns string with <Encoding:US-ASCII>
    # convert to default encoding
    ##  todo/fix: do NOT hardcode UTF-8 - use default encoding - why? why not?
    hex = bin.unpack('H*').first
    ## note: hexdigits/chars (0-9a-f) should be safe, that is, always ASCII-7BIT/UTF_8 with needing to change any char codes
    hex.encode!( Encoding::UTF_8 )
    hex
  end
  alias_method :bytes_to_hex, :bin_to_hex
  alias_method :b_to_h,       :bin_to_hex
  alias_method :btoh,         :bin_to_hex


 ########
  # more helpers
  ## check if it is a hex (string)
  ##  - allow optiona 0x or 0X  and allow abcdef and ABCDEF
  HEX_RE = /\A(?:0x)?[0-9a-f]*\z/i
  def is_hex?( str )  !HEX_RE.match( str ).nil?; end
end   # module BytesHelper




class Bytes
  extend BytesHelper
  ## e.g. lets you use
  ##       Bytes.hex_to_bin( hex )
  ##       Bytes.bin_to_hex( bin )  etc.


  def self.from_hex( hex ) new( hex_to_bin( hex ) );  end

  ##  "semantic" constructor for wrapping (binary) strings e.g. same as Bytes.new(bin)
  def self.wrap( bin ) new( bin );  end


  def initialize( bin=String.new )
    ## note: for now will NOT dup(licate) passed in binary array
    ##    you only get a new binary array if no arg passed in e.g. Bytes.new
    @bin  = if bin.encoding != Encoding::ASCII_8BIT
             puts "!! WARN - Bytes.new - BINARY/ASCII-8BIT encoding expected; got: #{bin.encoding} for string:"
             pp bin

             bin.b
            else
               bin
            end
  end


  ## add more string methods - why? why not?
  extend Forwardable
  def_delegators :@bin, :encoding,
                        :size, :length


  def to_s() Bytes.bin_to_hex( @bin ); end
  alias_method :to_hex, :to_s

  def b()  @bin; end

  ## add to_a  alias for @bin.bytes() - why? why not?


  def ==(other)
    self.class == other.class && @bin == other.b
  end



  def self.convert( arg )
    ## used by Bytes() in global Kernel converter method
      if arg.is_a?( Bytes )
        arg   ## pass-through as is
      elsif arg.is_a?( String )
        ## todo/fix: use coerce to_str if arg is NOT a string - why? why not
        ##
        if arg.encoding == Encoding::ASCII_8BIT
          ## assume it's binary data - use as is (no hexstring conversion)
          Bytes.wrap( arg )   ## todo/check: return str as-is (without new) - why? why not?
        else    ## assume it's a hexstring
          Bytes.from_hex( arg )
        end
      else
       ## check for array or such e.g if arg.is_a? Array
          ## raise TypeError - why? why not?
         raise ArgumentError, "Bytes() expected String; got #{arg.class.name}"
      end
  end
end



class String
  def to_hex()  Bytes.bin_to_hex( self ); end
  ## add more aliases e.g. bin_to_hex or btoh or b_to_h or such - why? why not?

  ## note: built-in String#hex returns string converted
  ##                    to Integer  -same as String.to_i(16) !!!!
end




module Kernel
  def Bytes( arg )  Bytes.convert( arg ); end
end





puts Cocos::Module::Bytes.banner      ## say hello
