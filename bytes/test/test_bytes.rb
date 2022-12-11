###
#  to run use
#     ruby -I ./lib -I ./test test/test_bytes.rb


require 'helper'


class TestBytes < MiniTest::Test



  def test_hex
     hex = '6162'

    assert_equal hex, Bytes.bin_to_hex( 'ab'.b )
    assert_equal hex, Bytes.btoh( 'ab'.b )
    assert_equal hex, 'ab'.b.to_hex

    assert_equal hex,  Bytes.bin_to_hex( "\x61\x62".b )
    assert_equal hex,  Bytes.btoh( "\x61\x62".b )
    assert_equal hex,  "\x61\x62".b.to_hex

    assert_equal Encoding::UTF_8,  Bytes.bin_to_hex( 'ab'.b ).encoding



     bin = "\x61\x62".b   ## note: same as 'ab'.b
     bytes = Bytes.new( bin )

    assert_equal bytes,   Bytes.from_hex( '6162' )
    assert_equal bin,   Bytes.hex_to_bin( '6162' )
    assert_equal bytes,   Bytes.from_hex( "0x6162" )
    assert_equal bin,   Bytes.hex_to_bin( "0x6162" )

    assert_equal Encoding::ASCII_8BIT, Bytes.from_hex( "6162" ).encoding
    assert_equal Encoding::BINARY, Bytes.from_hex( "6162" ).encoding
    assert_equal Encoding::ASCII_8BIT, Encoding::BINARY


    bytes = Bytes.new( 'ab'.b )

    assert_equal  bytes, Bytes( '6162' )
    assert_equal  bytes, Bytes( '0x6162' )

    assert_equal  bytes,  Bytes( "ab".b )
    assert_equal  bytes,  Bytes( "\x61\x62".b )

    assert_equal  Encoding::ASCII_8BIT,  Bytes( "6162" ).encoding
    assert_equal  Encoding::ASCII_8BIT, Bytes( "ab".b ).encoding

    bytes = Bytes.new( '6162'.b )
    assert_equal  bytes,  Bytes( "6162".b )
    assert_equal  Encoding::ASCII_8BIT, Bytes( "6162".b ).encoding
  end

  def test_is_hex?
     assert  Bytes.is_hex?( '0x' )
     assert  Bytes.is_hex?( '0X' )
     assert  Bytes.is_hex?( '' )
     assert  Bytes.is_hex?( '0xff' )
     assert  Bytes.is_hex?( 'ff' )

     assert_equal  false,  Bytes.is_hex?( 'xx' )
  end

end  # class TestBytes
