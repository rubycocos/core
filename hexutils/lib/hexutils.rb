


##
##  todo/check:
##    allow/ignore whitespaces [ \t\n\r] in hex strings why? why not?
##
##  or add option with ignore e.g. ':' or such - why? why not?

class String
  ## use deprecated_hex or legacy_hex
  ##   or ??? such? - why? why not?
   alias_method :old_hex, :hex
   alias_method :hexnum,  :old_hex

   def hex?
      if self.empty?
        ## make empty string (e.g.'') a valid hex string - why? why not?
        ##   note:  0x (prefix only) is NOT a valid hex string
         true
      elsif self =~ /\A(0[xX])?[0-9a-fA-F]+\z/
        ## note:  allow 0x0 or 0xf  too or 0xfff or 0x123
        ##            that is uneven hexstrings
        ##                 a byte assumes always two chars
         true
      else
         false
      end
   end
   alias_method :is_hex?, :hex?

   def to_hex
     if self.empty?
        ## change encoding to utf_8 - why? why not?
        ##  always return a new string  why? why not?
       ''  ## note: assume utf_8 encoding for new string
     else
        ## note: always return a hex string with default encoding e.g. utf-8 - why? why not?
        ### check if unpack always works on bytes (or .b required???)
        self.unpack( 'H*' ).first.force_encoding( Encoding::UTF_8 )
     end
   end
   alias_method :hex, :to_hex
end  # class String


class NilClass
  def hex?() false; end
  alias_method :is_hex?, :hex?

##
#  open question -  add hex/to_hex to NilClass too (along like to_s/to_i/etc.)
#    why? why not?
  def to_hex
    ''   ## note: assume utf_8 encoding for new string
  end
  alias_method :hex, :to_hex
end  # class NilClass



module Kernel
  def encode_hex( bin )   ## bin_to_hex
    ## use ArgumentError or TypeError - why? why not?
    raise TypeError, "Value must be a string" unless bin.is_a?( String )
    ## note: always return a hex string with default encoding e.g. utf-8 - why? why not?
    bin.hex
  end


  def decode_hex( hex )
    ## use ArgumentError or TypeError - why? why not?
    raise TypeError, "Value must be a string" unless hex.is_a?( String )
    ##  note: for now allow whitespaces - get auto-removed - why? why not?
    hex = hex.gsub( /[ \t\r\n]/, '' )
    if hex.empty?   ## special case - empty string
      ''.b
    else
      raise TypeError, 'Non-hexadecimal char found' unless hex =~ /\A(0[xX])?[0-9a-fA-F]+\z/

      ## allow optional starting 0x - why? why not?
      hex = hex[2..-1]    if ['0x', '0X'].include?( hex[0,2] )

      hex = '0'+hex    if hex.size.odd?
      [hex].pack('H*')
    end
  end
  alias_method :hex, :decode_hex

## open question - add "global" bin_to_hex and hex_to_bin alias to - why? why not?

#  alias_method :bin_to_hex, :encode_hex   ## add bin_to_hex alias - why? why not?
#  alias_method :hex_to_bin, :decode_hex    ## add hex_to_bin alias - why? why not?
end  # module Kernel

