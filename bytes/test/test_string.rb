###
#  to run use
#     ruby -I ./lib -I ./test test/test_string.rb


require 'helper'


class TestString < MiniTest::Test


  def test_encoding
    assert_equal Encoding::BINARY, Encoding::ASCII_8BIT
  end


  def test_string
     ####
     # note:  1) String.new gets you String with "binary" encoding
     #        2) String Literal "" and String.new("")
     #              gets you String with default encoding (utf-8)

     assert_equal Encoding::ASCII_8BIT, String.new.encoding
     assert_equal Encoding::ASCII_8BIT, String.new(''.b).encoding
     assert_equal Encoding::ASCII_8BIT, ''.b.encoding

     assert_equal Encoding::BINARY, String.new.encoding
     assert_equal Encoding::BINARY, String.new(''.b).encoding
     assert_equal Encoding::BINARY, ''.b.encoding

     assert_equal Encoding::UTF_8, ''.encoding
     assert_equal Encoding::UTF_8, String.new('').encoding
  end


  def test_bytes
     assert_equal Encoding::ASCII_8BIT, Bytes.new.encoding
     assert_equal Encoding::ASCII_8BIT, Bytes.new(''.b).encoding
     assert_equal Encoding::ASCII_8BIT, Bytes.new('ab'.b).encoding
  end

end  # class TestString
