
require 'helper'


class TestVersion < MiniTest::Test

  def test_version

   puts ConfUtils::VERSION

   assert true
  end

end # class test_version
