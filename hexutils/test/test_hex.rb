##
#  to run use
#     ruby -I ./lib -I ./test test/test_hex.rb


require 'helper'



class TestHex < MiniTest::Test


  def assert_bin( exp, bin )
    assert         bin.encoding == Encoding::BINARY
    assert_equal   exp, bin
  end


  def test_hexnum   ## old String.hex
    assert_equal  255, 'ff'.hexnum
    assert_equal  255, '0xff'.hexnum
    assert_equal  255, '0XFF'.hexnum
    assert_equal  255, '      ff'.hexnum
    assert_equal  255, '      ff       '.hexnum
    assert_equal  255, '      ff       xxxxx'.hexnum
    assert_equal  255, '      ffxxxxx'.hexnum
    assert_equal  255, '      0xff'.hexnum
    assert_equal  255, '      0xff       '.hexnum
    assert_equal  255, '      0xff       xxxxx'.hexnum
    assert_equal  255, '      0xffxxxxx'.hexnum

    assert_equal  15, 'f'.hexnum
    assert_equal  15, '0xf'.hexnum
    assert_equal  15, '0XF'.hexnum

    assert_equal  0, ''.hexnum
    assert_equal  0, 'xxxxx'.hexnum
  end

  def test_string
    tests = [
      [''.b,       ''],
      ["\xff".b,  'ff'],
      ["\x00".b,  '00'],
      ["\xf".b,   '0f'],  ## note: 0xf is same as 0x0f (two chars required for byte) !!!
      ["\x0f".b,  '0f'],

      ["\x1\x23".b,   '0123'],
      ["\x01\x23".b,  '0123'],
      ["\x32\x1".b,   '3201'],
      ["\x32\x01".b,  '3201'],

      ["\x00".b*10,  '00000000000000000000'],
      ["\xff".b*10,  'ffffffffffffffffffff'],
    ]

    tests.each do |bin, hex|
      assert_equal hex, bin.to_hex
      assert_equal hex, bin.hex
    end

    ## skip first empty string test
    tests[1..-1].each do |bin, hex|
      assert  hex.hex?
      assert  hex.is_hex?

      hex0x  = '0x'+hex
      assert  hex0x.hex?
      assert  hex0x.is_hex?

      hex0X  = '0X'+hex.upcase
      assert  hex0X.hex?
      assert  hex0X.is_hex?

      assert bin.hex? == false
      assert bin.is_hex? == false
    end
  end


  def test_kernel
    tests = [
      ["\xff".b,  'ff'],
      ["\x00".b,  '0'],
      ["\xf".b,   'f'],  ## note: 0xf is same as 0x0f (two chars required for byte) !!!
      ["\x0f".b,  'f'],
      ["\xf".b,   '0f'],
      ["\x0f".b,  '0f'],

      ["\x1\x23".b,   '123'],
      ["\x01\x23".b,  '0123'],

      ["\x32\x1".b,  '3201'],
      ["\x32\x01".b,  '3201'],

      ["\x00".b*10,  '00000000000000000000'],
      ["\xff".b*10,  'ffffffffffffffffffff'],
    ]

    tests.each do |bin, hex|
      assert_bin bin, hex( hex )
      assert_bin bin, decode_hex( hex )

      hex0x = '0x'+hex
      assert_bin bin, hex( hex0x  )
      assert_bin bin, decode_hex( hex0x )

      hex0X = '0X'+hex.upcase
      assert_bin bin, hex( hex0X  )
      assert_bin bin, decode_hex( hex0X )
    end

    tests = [
      'ff',
      '00',
      'ffff',
      '0000',
    ]

    tests.each do |hex|
       assert_equal hex, encode_hex( decode_hex( hex ) )
    end

    ## test empty string
    assert_bin ''.b, decode_hex( '' )
    assert_equal '', encode_hex( decode_hex( '' ))
  end

end  ## class TestHex
