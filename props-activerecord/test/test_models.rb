# encoding: utf-8

require 'helper'

class TestModels < MiniTest::Test

  def setup
    ConfDb.delete!
  end

  def test_count
    assert_equal 0, Prop.count
  end


  def test_create
    prop = Prop.create!( key: 'key', value: 'value' )

    assert_equal 1, Prop.count
  end

end # class TestModels
